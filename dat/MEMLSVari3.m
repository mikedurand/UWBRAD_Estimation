% Run MEMLS for sensitive study 3.0
% Correct the mistake in 2.0 of Robin temperature calculation 
% Yuna March 12th, 2015

%% get temperature profile form Robin profile

clear
% 1.get robin model input along the flight line
load profile_resample.mat
G=[0.03 0.06 0.09];% basal heat flux [w/m2]
Ts=downsample(profile_resample.Ts,2);%surface temperature
Ts(:,2)=Ts(:,1)+3;
Ts(:,3)=Ts(:,1)-3;
H=downsample(profile_resample.thickness,2); % ice sheet thickness
M=downsample(profile_resample.smb.*12/1000,2);% accumulation rate [m/yr]

% 2.remove points with negative accumulation rate
negative=M<=0;negative=logical(negative+isnan(M));
M(negative)=[];H(negative)=[];
Ts(1:3,:)=[];
Ts(48:52,:)=[];

PointNum=length(M);
getgrid=false;

if getgrid
    for i=1:length(H)
        Grid2{i}=GetGrid2(false,H(i),0.1,1,5);
    end
else
    load Grid2.mat
end
for i=1:PointNum
    num=0;
    for g=1:3
        for t=1:3
            num=num+1;
            h=H(i);
            temp{num,i}=TempProfile2(h,G(g),M(i),Ts(i,t),h-Grid2{i}.Z); 
        end
    end
end


%% get denisty profile with different std
addpath ~/Documents/MyMath/Project/UWBRAD/density_fit/NewDensityModel;
std=[20 40 60];% standrad deviation for density profile
load DensityModel.mat;
load DensityAnomModel2.mat;
RhoMod.AnomParams=AnomParams;

S=load('~/Documents/MyMath/Project/UWBRAD/density_fit/NewDensityModel/RandState.mat');
%fit model
rhoFit=[];
for j=1:3
    RhoMod.StdAnom=std(j);
    for i=1:PointNum
        rhoFit{j,i}=GetRealizations_v2(RhoMod,Grid2{i},1,S);  
    end
end

%% Run MEMLS

% Put together MEMLS inputs
fGHz=[0.54,0.66,0.78,0.9,1.02,1.14,1.26,1.38,1.5,1.62,1.74,1.86,1.98];
tetad=[0 40 50];
s0h=0.05;
s0v=0.05;

Tsky=2;
Tgnd=zeros(47,1);
scopt=3; %empirical scattering coefficient, using correlation length only 


for i=1:PointNum
    disp(['Running point '  num2str(i) '/' num2str(47)])
    a=0;
    Lyr{i}.Num=1:length(Grid2{i}.Z);%Layer numbers,
    Lyr{i}.LWC=zeros(size(Lyr{i}.Num));%Liquid water:, zeroes
    Lyr{i}.Dz=flip(Grid2{i}.dz.*100);%Layer thickness [cm]
    Lyr{i}.Sal=zeros(size(Lyr{i}.Num));% Salinity [ppt]
    
    for t=1:9
        disp(['Running temperature variation '  num2str(t) '/' num2str(27)])
        Lyr{i}.T=flip(temp{t,i});% Temperature,bottom-first
        Tgnd(i)=Lyr{i}.T(1);

        for d=1:3
            disp(['Running density variation '  num2str(d) '/' num2str(3)])
            Lyr{i}.Rho=flip(rhoFit{d,i});% Density,bottom-first order
            %Grain size,bottom-first
            D=[];v=[];L=[];
            D=flip(1+Grid2{i}.Z.*.25/100); %[mm]bottom-first order
            v=Lyr{i}.Rho./910;
            L=D./2.*(1-v); %[mm]
            L(flip(Grid2{i}.Z)>100)=0;
            L(L<1E-5)=0;
            Lyr{i}.L=L./1000; %[m]
            
            Profile=[];         
            Profile(:,1)=Lyr{i}.Num';
            Profile(:,2)=Lyr{i}.T';
            Profile(:,3)=Lyr{i}.LWC';
            Profile(:,4)=Lyr{i}.Rho';
            Profile(:,5)=Lyr{i}.Dz';
            Profile(:,6)=Lyr{i}.Sal';
            Profile(:,7)=Lyr{i}.L';
            tic
            %QuadPlotDepth(Profile,Grid2{1},1)
            
            for f=1:length(fGHz)
                disp(['point' num2str(i) 'Running frequency '  num2str(f) '/' num2str(length(fGHz) ) ...
                '. Elapsed time=' num2str(toc) 'seconds.' ])
    
                for q=1:3
                    [Tbh(q,f,d,t,i),Tbv(q,f,d,t,i)] = memlsfuncIgnoreCoh(fGHz(f),tetad(q),s0h,s0v,Profile,Tsky,Tgnd(i),scopt);   
                end
            end
            toc
        
        end
    end
end

save ('TbMEMLS','Tbh','Tbv');

%% Compute the UWBRAD Tb from antenna pattern 

%1.Get sensor data, antenna pattern file from Mustafa

%  cover theta=-180 to theta=180 with 2 degree intervals.
%  Assume symmetry over azimuth
%  The UWBRAD frequency is obtained to closest frequency in the antenna
%  pattern file

fname='ConicalSpiral_40Turns_NoseConeGeometry.csv';
AntennaPattern=csvread(fname,1,1,[1,1,181,16]);    
SensorTheta=180:-2:-180;
SensorfGHz=linspace(0.5,2,16);

%2.Calculate weighted average 
%  weights by linear gain

for f=1:length(fGHz)
    [~,fclose]=min(fGHz(f)-SensorfGHz);    
    for q=1:length(tetad),
        j=find(SensorTheta==tetad(q));
        GdB(q,f)=AntennaPattern(j,fclose);
    end
    
end
Glin=10.^(GdB./10);

for i=1:47
    for t=1:9
        for d=1:3
            UWBRADh(:,:,d,t,i)=sum(Tbh(:,:,d,t,i).*Glin)./sum(Glin);
            UWBRADv(:,:,d,t,i)=sum(Tbv(:,:,d,t,i).*Glin)./sum(Glin);
        end
    end
end

UWBRADc=(UWBRADv+UWBRADh)./2;

%save ('TbUWBRAD','UWBRADh','UWBRADv','UWBRADc');

%% Send a e-mail to me
mailme;
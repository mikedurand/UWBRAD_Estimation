% Temperature fit along the flight track every 10 km
% Using Robin's model
% Icesheet thickness comes from interpoloated OIB data
% Surface temperature and accumulation rate come from 
% RACMO model simulation
% Yuna Nov 10th, 2014 
clear
load('./flightline_data.mat')
subplot(2,2,1)
plot(resample_thickness(:,3))
title('resample icesheet thickness along flight line')
subplot(2,2,2)
plot(resample_heatflux)
title('resample geothermal heatflux along the flight line')

% define parameters for Robin Model
k_c=2.70;%ice thermal conductivity
k_d=45;%thermal diffusivity
H=resample_thickness(:,3);%Ice sheet thickness
G=resample_heatflux/1000;% ground geothermal heatflux, w/m2
% Average surface temperature Ts,[K]
for i=1:length(Fl_RACMO),
    Ts(i)=mean(Fl_RACMO(i).tskin);
end
% Surface mass balance
for i=1:length(Fl_RACMO),
    smbavg(i)=mean(Fl_RACMO(i).smb);
end
M=smbavg.*12/1000;%unit [mwe]

subplot(2,2,3)
plot(M)
title('accumulation rate along the flight line')
subplot(2,2,4)
plot(Ts)
title('surface temperature along the flight line')
% The first two position on the flight line has no data for smb
% use precip-runoff instead
% they are pretty close on the margin, I think
for i=1:2
 ppt(i)=mean(Fl_RACMO(i).precip);
 runoff(i)=mean(Fl_RACMO(i).runoff);
 M(i)=(ppt(i)*12-runoff(i)*12)/1000;
end

for i=1:length(Fl_RACMO)
    zstation=flip(linspace(0,H(i),H(i)));
    z{i}=zstation;
end

%Using Robin's model to calculate the temp
%Don't know how to deal the negative accumulation place
%so remove the points with negative m
M(M<=0)=[];
H(M<=0)=[];
G(M<=0)=[];
Ts(M<=0)=[];
for i=1:164
    z2{i}=z{i+4};
end

for i=1:length(M)
    h=z2{i};
    temp{i}=TempProfile2(H(i),G(i),M(i),Ts(i),h);   
end

clearvars -except temp








clear all

load('dat/TbUWBRAD-v2.mat');
TbUWBRADOrig=TbUWBRADc; clear TbUWBRADc

%dimensions of original data:
%1 ~ frequency, f
%2 ~ density standard deviation, rho
%3 ~ temperature: includes dT & G
%4 ~ spatial location

%reorganizition: part 1/2
%1 ~ frequency, f
%2 ~ density standard deviation, rho
%3 ~ surface temperature: dT
%4 ~ ground heat flux: G
%5 ~ spatial location

for i=1:length(f),
    for j=1:length(rho)
        for k=1:length(dT),
            for m=1:length(B),
                for n=1:nx,
                    p=(k-1)*length(dT)+m;
                    TbUWBRAD(i,j,k,m,n)=TbUWBRADOrig(i,j,p,n);
                end
            end
        end
    end
end

%reorganizition: part 2/2
% need to make dT increase monotonically
temp=TbUWBRAD;
TbUWBRAD(:,:,1,:,:)=temp(:,:,3,:,:);
TbUWBRAD(:,:,2,:,:)=temp(:,:,1,:,:);
TbUWBRAD(:,:,3,:,:)=temp(:,:,2,:,:);

dT=sort(dT,'ascend');

save('dat/TbUWBRAD.mat','TbUWBRAD','f','rho','dT','B','nx');
clear all

% load('dat/TbUWBRAD.mat','UWBRADc')
load('dat/TbMEMLS.mat')

UWBRADSensor=GetSensorData('~/Data/UWBRAD/CSA_antenna_phi0_theta_pattern.dat');

f=[0.54  0.66  0.78  0.9  1.02  1.14  1.26  1.38 1.5  1.62  1.74  1.86  1.98];
rho=[20 40 60];
dT=[0 3 -3];
B=[30 60 90];
tetad=[0 40 50];
nx=47;

for i=1:length(f),
    for q=1:length(tetad),
        Gi(q)=interp2(UWBRADSensor.Freq,UWBRADSensor.Theta,UWBRADSensor.GaindB,f(i),tetad(q),'spline');
    end
    
    Glin=10.^(Gi./10);
    
    for j=1:length(rho),
        for k=1:length(dT)*length(B),
            for m=1:nx,
                TbUWBRADv(i,j,k,m)=sum(Glin'.*Tbv(:,i,j,k,m))./sum(Glin);
                TbUWBRADh(i,j,k,m)=sum(Glin'.*Tbh(:,i,j,k,m))./sum(Glin);
            end
        end
    end
end

TbUWBRADc=(TbUWBRADv+TbUWBRADh)./2;

figure(1)
plot(f,TbUWBRADc(:,1,1,25))

save('dat/TbUWBRAD-v2.mat','TbUWBRADc','f','rho','dT','B','tetad','nx')
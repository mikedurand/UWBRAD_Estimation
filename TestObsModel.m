%script to test interp3 of the UWBRAD data

clear all

D=load('dat/TbUWBRAD.mat');

x=20;

rhoi=rand.*range(D.rho)+min(D.rho);
dTi=rand.*range(D.dT)+min(D.dT);
Bi=rand.*range(D.B)+min(D.B);

Tbi=ObsModel(D,rhoi,dTi,Bi,x);

for i=1:length(D.rho),
    for j=1:length(D.dT),
        for k=1:length(D.B),
            plot(D.f,squeeze(D.TbUWBRAD(:,i,j,k,x)),'b--'); hold on;
        end
    end
end

plot(D.f,Tbi,'k-'); hold off;


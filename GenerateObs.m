%script to generate UWBRAD observations via perturbation

clear all

D=load('dat/TbUWBRAD.mat');
load('dat/CISMG.mat');

sigTb=0.5; %observational uncertainty

Tbi=nan(length(D.f),D.nx);

for i=1:D.nx
    rhot(i)=30;
    dTt(i)=0;
    Bt(i)=double(CISMG(i))*1000;
    Tbi(:,i)=ObsModel(D,rhot(i),dTt(i),Bt(i),i);
end

v=randn(size(Tbi)).*sigTb;

TbObs=Tbi+v;

figure(1)
pcolor(1:D.nx,D.f,TbObs)
set(gca,'FontSize',14)
xlabel('Distance along flight line')
ylabel('Frequency, GHz')
colorbar

save('dat/TbObs.mat','sigTb','TbObs','rhot','dTt','Bt')
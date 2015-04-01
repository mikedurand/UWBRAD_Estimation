%script to generate UWBRAD observations via perturbation

%clear all

% load TbUWBRAD from different running
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

figure(1)
plot(D.f,Tbi)

v=randn(size(Tbi)).*sigTb;

TbObs=Tbi+v;

figure(2)
pcolor(1:D.nx,D.f,TbObs)
set(gca,'FontSize',14)
xlabel('Distance along flight line')
ylabel('Frequency, GHz')
colorbar

save('dat/TbObs.mat','sigTb','TbObs','rhot','dTt','Bt')
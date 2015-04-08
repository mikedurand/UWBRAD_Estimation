%clear all

frun=['runs/Exp' num2str(ExpNum) '.mat'];
load (frun);
load dat/Robin_Sensitive_study.mat

%% estimate & temperature profiles
iUse=1:N>N/5;
rhohat=median(rhoc(iUse));
dThat=median(dTc(iUse));
Bhat=median(Bc(iUse));

[tempt,z] = TempProfile(H(x),Bt/1000,M(x),Ts(x,1)+dTt);

[temphat] = TempProfile(H(x),Bhat/1000,M(x),Ts(x,1)+dThat);

tempc=nan(N,length(temphat));
for i=1:N,
    tempc(i,:)=TempProfile(H(x),Bc(i)/1000,M(x),Ts(x,1)+dTc(i));
end

for i=1:length(temphat),
    tempMedHat(i)=median(tempc(:,i));
    tempStdHat(i)=std(tempc(:,i));
end

%% plots
figure(3)
subplot(311)
plot(rhoc)
ylabel('\sigma_\rho')
subplot(312)
plot(dTc)
ylabel('dT')
subplot(313)
plot(Bc)
ylabel('B')

i=N/5+1:N;

figure(4)
subplot(221)
plot(rhoc(i),dTc(i),'.')
xlabel('\sigma_\rho')
ylabel('dT, K')
subplot(222)
plot(rhoc(i),Bc(i),'.')
xlabel('\sigma_\rho')
ylabel('B, mW')
subplot(223)
plot(dTc(i),Bc(i),'.')
xlabel('dT')
ylabel('B, mW')

figure(5)
subplot(221)
hist(rhoc(i))
xlabel('\sigma_\rho')
subplot(222)
hist(dTc(i))
xlabel('dT')
subplot(223)
hist(Bc(i))


rhohat=median(rhoc(iUse));
dThat=median(dTc(iUse));
Bhat=median(Bc(iUse));

figure(6)

plot3(rhoc(i),dTc(i),Bc(i),'.')

set(gca,'FontSize',14)
grid on
xlabel('\sigma_\rho, kg/m^3')
ylabel('Surf temperature offset, K')
zlabel('Basal heat flux, mW/m^2')

figure(7)
plot(tempt,-z,temphat,-z,tempMedHat,-z); 
legend('tempt','temphat','tempMedHat')


figure(8)
plot(1:N,Tbc)

figure(9)
plot(1:N,lf)



%% plots for visiual inspection of convergence
% 1.mean plot
BMeani=cumsum(Bc);rhoMeani=cumsum(rhoc);dTcMeani=cumsum(dTc);
inum=1:N;
BMeani=BMeani./inum;rhoMeani=rhoMeani./inum;dTcMeani=dTcMeani./inum;

figure(10)
set(gca,'fontsize',14)
subplot(2,2,1);plot(inum,rhoMeani)
xlabel('iteration');ylabel('mean \sigma_\rho');grid on
subplot(2,2,2);plot(inum,dTcMeani)
xlabel('iteration');ylabel('mean dT');grid on
subplot(2,2,3);plot(inum,BMeani)
xlabel('iteration');ylabel('mean B');grid on

%% 2.autocorrelation plot
lag=300;
for i=1:lag
    rlagRho(i)=ACF_k(rhoc,i);
    rlagdT(i)=ACF_k(dTc,i);
    rlagdT(i)=ACF_k(Bc,i);
end

figure(11)
set(gca,'fontsize',14)
grid on
subplot(2,2,1);plot(1:lag,rlagRho)
xlabel('lag');ylabel('ACF \sigma_\rho');grid on
subplot(2,2,2);plot(1:lag,rlagdT);grid on
xlabel('lag');ylabel('ACF dT')
subplot(2,2,3);plot(1:lag,rlagdT);grid on
xlabel('lag');ylabel('ACFn B')

%%
% igrn=49607;
% igrn=40870;
igrn=5000;
[temp_grn] = TempProfile(H(x),Bc(igrn)/1000,M(x),Ts(x,1)+dTc(igrn));
% iylw=31675;
% iylw=15498;
iylw=6000;
[temp_ylw] = TempProfile(H(x),Bc(iylw)/1000,M(x),Ts(x,1)+dTc(iylw));
% ior=27655;
% ior=12182;
ior=7000;
[temp_or] = TempProfile(H(x),Bc(ior)/1000,M(x),Ts(x,1)+dTc(ior));
% ired=35194;
% ired=25908;
ired=8000;
[temp_red] = TempProfile(H(x),Bc(ired)/1000,M(x),Ts(x,1)+dTc(ired));
% igry=17743;
% igry=33780;
igry=9000;
[temp_gry] = TempProfile(H(x),Bc(igry)/1000,M(x),Ts(x,1)+dTc(igry));
% iprp=17675;
% iprp=37873;
iprp=10000;
[temp_prp] = TempProfile(H(x),Bc(iprp)/1000,M(x),Ts(x,1)+dTc(iprp));

figure(12)
h=plot(tempt,-z,temp_grn,-z,temp_ylw,-z,temp_or,-z,temp_red,-z,temp_gry,-z,...
    temp_prp,-z,'LineWidth',2);
set(h(1),'Color','k'); set(h(2),'Color',[112 191 65]./255);
set(h(3),'Color',[245 211 40]./255); set(h(4),'Color',[243 144 25]./255);
set(h(5),'Color',[236 93 87]./255); set(h(6),'Color',[166 170 169]./255); 
set(h(7),'Color',[179 106 226]./255);
set(gca,'FontSize',14)
xlabel('Temperature, K')
ylabel('Depth, m')

figure(13)
h=plot(D.f,TbObs,'o',D.f,Tbc(igrn,:),D.f,Tbc(iylw,:),D.f,Tbc(ior,:),...
    D.f,Tbc(ired,:),D.f,Tbc(igry,:),D.f,Tbc(iprp,:),'LineWidth',2);
set(h(1),'Color','k'); set(h(2),'Color',[112 191 65]./255);
set(h(3),'Color',[245 211 40]./255); set(h(4),'Color',[243 144 25]./255);
set(h(5),'Color',[236 93 87]./255); set(h(6),'Color',[166 170 169]./255); 
set(h(7),'Color',[179 106 226]./255);
set(gca,'FontSize',14)
xlabel('Frequency, GHz')
ylabel('Brightness tempearture, K')



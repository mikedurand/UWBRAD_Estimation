clear all

ExpNum=10;

frun=['runs/Exp' num2str(ExpNum) '.mat'];
load (frun);
load dat/Robin_Sensitive_study.mat

%% estimate & temperature profiles
iUse=1:N>N/5; %burn in
rhohat=median(rhoc(iUse));%use the median to estimate the true values
dThat=median(dTc(iUse));
Bhat=median(Bc(iUse));

% Try if it there is a better temp estimation to use mean weighted by 
% frequency. Also the corresponding tempE is calculated and ploted
% Check the script ExpectionEstimate to see if it makes sense.
% Add by Yuna-April 15th
ExpectionEstimate; 

[tempt,z] = TempProfile(H(x),Bt/1000,M(x),Ts(x,1)+dTt);

[temphat] = TempProfile(H(x),Bhat/1000,M(x),Ts(x,1)+dThat);

[tempE] = TempProfile(H(x),EB/1000,M(x),Ts(x,1)+EdT);

% tempc=nan(N,length(temphat));
% for i=1:N,
%     tempc(i,:)=TempProfile(H(x),Bc(i)/1000,M(x),Ts(x,1)+dTc(i));
% end
% 
% for i=1:length(temphat),
%     tempMedHat(i)=median(tempc(:,i));
%     tempStdHat(i)=std(tempc(:,i));
% end

%% plots
figure(4)
subplot(311)
plot(rhoc)
ylabel('\sigma_\rho, kg/m^3')
set(gca,'FontSize',14)
grid
subplot(312)
plot(dTc)
ylabel('dT')
set(gca,'FontSize',14)
grid
subplot(313)
plot(Bc)
ylabel('B, mW/m^2')
xlabel('Iteration #')
set(gca,'FontSize',14)
grid

i=N/5+1:N;

figure(5)
subplot(221)
plot(rhoc(i),dTc(i),'.')
xlabel('\sigma_\rho')
ylabel('dT, K')
set(gca,'FontSize',14)
subplot(222)
plot(rhoc(i),Bc(i),'.')
xlabel('\sigma_\rho')
ylabel('B, mW')
set(gca,'FontSize',14)
subplot(223)
plot(dTc(i),Bc(i),'.')
xlabel('dT')
ylabel('B, mW')
set(gca,'FontSize',14)

figure(6)
subplot(221)
histogram(rhoc(i))
set(gca,'FontSize',14)
xlabel('\sigma_\rho, kg/m3')
subplot(222)
histogram(dTc(i))
set(gca,'FontSize',14)
xlabel('dT, °C')
subplot(223)
histogram(Bc(i))
set(gca,'FontSize',14)
xlabel('Basal heat flux, mW/m^2')


rhohat=median(rhoc(iUse));
dThat=median(dTc(iUse));
Bhat=median(Bc(iUse));

figure(7)

plot3(rhoc(i),dTc(i),Bc(i),'.')

set(gca,'FontSize',14)
grid on
xlabel('\sigma_\rho, kg/m^3')
ylabel('Surf temperature offset, K')
zlabel('Basal heat flux, mW/m^2')

figure(8)
plot(tempt,-z,temphat,-z,tempE,-z,'LineWidth',2); 
legend('tempt','temphat','tempE')
set(gca,'FontSize',14)
ylabel('Depth, m')
xlabel('Temperature, K')

figure(9)
plot(1:N,Tbc)

figure(10)
plot(1:N,lf)



%% plots for visiual inspection of convergence
% 1.mean plot
BMeani=cumsum(Bc);rhoMeani=cumsum(rhoc);dTcMeani=cumsum(dTc);
inum=1:N;
BMeani=BMeani./inum;rhoMeani=rhoMeani./inum;dTcMeani=dTcMeani./inum;

figure(11)
subplot(2,2,1);plot(inum,rhoMeani)
set(gca,'fontsize',14)
xlabel('iteration');ylabel('mean \sigma_\rho');grid on
subplot(2,2,2);plot(inum,dTcMeani)
set(gca,'fontsize',14)
xlabel('iteration');ylabel('mean dT');grid on
subplot(2,2,3);plot(inum,BMeani)
set(gca,'fontsize',14)
xlabel('iteration');ylabel('mean B');grid on

%% 2.autocorrelation plot
% lag=300;
% for i=1:lag
%     rlagRho(i)=ACF_k(rhoc,i);
%     rlagdT(i)=ACF_k(dTc,i);
%     rlagdT(i)=ACF_k(Bc,i);
% end
% 
% figure(12)
% set(gca,'fontsize',14)
% grid on
% subplot(2,2,1);plot(1:lag,rlagRho)
% xlabel('lag');ylabel('ACF \sigma_\rho');grid on
% subplot(2,2,2);plot(1:lag,rlagdT);grid on
% xlabel('lag');ylabel('ACF dT')
% subplot(2,2,3);plot(1:lag,rlagdT);grid on
% xlabel('lag');ylabel('ACFn B')

% A whole bunch of working NOT in vain 
igrn=33798;
[temp_grn] = TempProfile(H(x),Bc(igrn)/1000,M(x),Ts(x,1)+dTc(igrn));

iylw=33433;
[temp_ylw] = TempProfile(H(x),Bc(iylw)/1000,M(x),Ts(x,1)+dTc(iylw));

ired=32344;
[temp_red] = TempProfile(H(x),Bc(ired)/1000,M(x),Ts(x,1)+dTc(ired));

ipur=33553;
[temp_pur] = TempProfile(H(x),Bc(ipur)/1000,M(x),Ts(x,1)+dTc(ipur));

figure(13)
h=plot(tempt,-z,temp_grn,-z,temp_ylw,-z,temp_red,-z,temp_pur,-z,'LineWidth',2);
set(h(1),'Color','k'); 
set(h(2),'Color',[112 191 65]./255); %green
set(h(3),'Color',[245 211 40]./255); 
set(h(4),'Color',[236 93 87]./255); 
set(h(5),'Color',[179 106 226]./255); 
set(gca,'FontSize',14)
xlabel('Temperature, K')
ylabel('Depth, m')

figure(14)
h=plot(D.f,TbObs,'o',D.f,Tbc(igrn,:),D.f,Tbc(iylw,:),D.f,Tbc(ired,:),D.f,Tbc(ipur,:),'LineWidth',2);
set(h(1),'Color','k'); 
set(h(2),'Color',[112 191 65]./255);
set(h(3),'Color',[245 211 40]./255); 
set(h(4),'Color',[236 93 87]./255); 
set(h(5),'Color',[179 106 226]./255); 
set(gca,'FontSize',14)
xlabel('Frequency, GHz')
ylabel('Brightness tempearture, K')
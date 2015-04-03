%clear all

frun=['runs/Exp' num2str(ExpNum) '.mat'];
load (frun);
load dat/Robin_Sensitive_study.mat

%% estimate & temperature profiles
i=N/5+1:N;
rhohat=median(rhoc(i));
dThat=median(dTc(i));
Bhat=median(Bc(i));

[tempt,z] = TempProfile(H(x),Bt/1000,M(x),Ts(x,1)+dTt);

[temphat] = TempProfile(H(x),Bhat/1000,M(x),Ts(x,1)+dThat);


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
% i=N-20000:N;
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
set(gca,'fontsize',14)

figure(5)
subplot(221)
hist(rhoc(i))
xlabel('\sigma_\rho')
subplot(222)
hist(dTc(i))
xlabel('dT')
subplot(223)
hist(Bc(i))
xlabel('B, mW')

rhohat=median(rhoc(i));
dThat=median(dTc(i));
Bhat=median(Bc(i));

figure(6)
plot3(rhoc(i),dTc(i),Bc(i),'.')
set(gca,'FontSize',14)
grid on
xlabel('\sigma_\rho, kg/m^3')
ylabel('Surf temperature offset, K')
zlabel('Basal heat flux, mW/m^2')

figure(7)
plot(tempt,-z,temphat,-z); 
legend('tempt','temphat')

figure(8)
plot(1:N,Tbc)

figure(9)
plot(1:N,lf)
xlabel('iteration');ylabel('lookhood')


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
% figure(10)
% plot(D.f,median(Tbc(200:400,:)),D.f,median(Tbc(700:800,:)))
% rhoMode1=median(rhoc(200:400));
% dTMode1=median(dTc(200:400));
% BMode1=median(Bc(200:400));
% 
% rhoMode2=median(rhoc(700:800));
% dTMode2=median(dTc(700:800));
% BMode2=median(Bc(700:800));
% 
% [tempMode1] = TempProfile(H(x),BMode1/1000,M(x),Ts(x,1)+dTMode1);
% [tempMode2] = TempProfile(H(x),BMode2/1000,M(x),Ts(x,1)+dTMode2);
% 
% figure(11)
% plot(tempMode1,-z,tempMode2,-z,tempt,-z)
%%
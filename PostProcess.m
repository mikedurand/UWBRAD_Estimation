clear all

load runs/Exp1.mat
load dat/Robin_Sensitive_study.mat

%% estimate & temperature profiles
i=N/5+1:N;
rhohat=median(rhoc(i));
dThat=median(dTc(i));
Bhat=median(Bc(i));

[tempt,z] = TempProfile(H(x),Bt/1000,M(x),Ts(x,1)+dTt);

[temphat] = TempProfile(H(x),Bhat/1000,M(x),Ts(x,1)+dThat);


%% plots
figure(1)
subplot(311)
plot(rhoc)
ylabel('\rho')
subplot(312)
plot(dTc)
ylabel('dT')
subplot(313)
plot(Bc)
ylabel('B')

i=N/5+1:N;
% i=N-20000:N;
figure(2)
subplot(221)
plot(rhoc(i),dTc(i),'.')
subplot(222)
plot(rhoc(i),Bc(i),'.')
subplot(223)
plot(dTc(i),Bc(i),'.')

figure(3)
subplot(221)
hist(rhoc(i))
subplot(222)
hist(dTc(i))
subplot(223)
hist(Bc(i))

rhohat=median(rhoc(i));
dThat=median(dTc(i));
Bhat=median(Bc(i));

figure(4)
plot3(rhoc(i),dTc(i),Bc(i),'.')
set(gca,'FontSize',14)
grid on
xlabel('\sigma_\rho, kg/m^3')
ylabel('Surf temperature offset, K')
zlabel('Basal heat flux, mW/m^2')

figure(5)
plot(tempt,-z,temphat,-z); 
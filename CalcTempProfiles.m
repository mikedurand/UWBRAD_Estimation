%calculate temperature profiles

clear all

load runs/Exp1.mat
load dat/Robin_Sensitive_study.mat

% true temperature profile
[tempt,z] = TempProfile(H(x),Bt/1000,M(x),Ts(x,1)+dTt);

%%
i=N/5+1:N;
rhohat=median(rhoc(i));
dThat=median(dTc(i));
Bhat=median(Bc(i));

[temphat] = TempProfile(H(x),Bhat/1000,M(x),Ts(x,1)+dThat);
plot(tempt,-z,temphat,-z); 
clear all

Exps=[1:3 5:53];

for e=1:length(Exps),
    
    ExpNum=Exps(e);

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

    [tempt{e},z{e}] = TempProfile(H(x),Bt/1000,M(x),Ts(x,1)+dTt);

    [temphat{e}] = TempProfile(H(x),Bhat/1000,M(x),Ts(x,1)+dThat);

    [tempE{e}] = TempProfile(H(x),EB/1000,M(x),Ts(x,1)+EdT);
    
    %calculate error statistics
    [~,j]=min( abs( z{e} - 10  ) );
    
    T10t(e)=tempt{e}(j);
    T10m(e)=temphat{e}(j);
    T10e(e)=tempE{e}(j);
    
    err10m(e)=T10m(e)-T10t(e);
    errE10m(e)=T10e(e)-T10t(e);
    
    Tavgt(e)=mean(tempt{e});
    Tavgm(e)=mean(temphat{e});
    Tavge(e)=mean(tempE{e});
    
    erravg(e)=Tavgm(e)-Tavgt(e);
    errEavg(e)=Tavge(e)-Tavgt(e);
    
    RMSm(e)=sqrt(mean( (tempt{e}-temphat{e}).^2 ) );
    RMSe(e)=sqrt(mean( (tempt{e}-tempE{e}).^2 ) );
end


%%
Nsta=length(Exps);

figure(1)
stem(1:Nsta,err10m); hold on;
stem(1:Nsta,errE10m,'r-'); hold off;

figure(2)
stem(1:Nsta,erravg); hold on;
stem(1:Nsta,errEavg,'r-'); hold off;

figure(3)
stem(1:Nsta,RMSm); hold on;
stem(1:Nsta,RMSe,'r-'); hold off;

figure(4)
plot(T10t,T10e,'o',[240 258],[240 258],'LineWidth',2)
set(gca,'FontSize',14)
title('Ten meter temperature, K')
xlabel('True temp, K')
ylabel('Estimated temp, K')

figure(5)
plot(Tavgt,Tavge,'o',[246 262],[246 262],'LineWidth',2)
set(gca,'FontSize',14)
title('Vertical aveage temperature, K')
xlabel('True temp, K')
ylabel('Estimated temp, K')

%%
sqrt(mean( (T10t-T10e).^2 ))
mean(T10e-T10t)

sqrt(mean( (Tavgt-Tavge).^2 ))
mean(Tavge-Tavgt)
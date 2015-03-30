%script to estimate density variations, surface temperature, and basal heat
%flux

%clear all

%load in data
%O=load('dat/TbObs.mat');
%D=load('dat/TbUWBRAD.mat');

%N=1E4; %MCMC iterations

%ExpNum=1;
%x=15; %location 1-47 to estimate

%estimating: sigrho,Ts,B
 
%initialize arrays
theta=nan(3,N);
na1=0;
na2=0;
na3=0;
jmpz=randn(3,N);
u=rand(3,N);

rhoc=nan(1,N);
dTc=nan(1,N);
Bc=nan(1,N);

%set up priors
murho=D.rho(2);
mudT=D.dT(2);
muB=D.B(2);
stdrho=range(D.rho)/2;
stddT=range(D.dT)/2;
stdB=range(D.B)/2;

%location to estiamte
TbObs=O.TbObs(:,x)';
rhot=O.rhot(x);
dTt=O.dTt(x);
Bt=O.Bt(x);

%first chain iteration calculations
rhoc(1)=murho;
dTc(1)=mudT;
Bc(1)=muB;

%jump parameters: standard deviation, and limits
%jump standard deviations: tune to get ~25% acceptance
jmprho=1.5;
jmpdT=.75;
jmpB=7;

rhomin=min(D.rho); 
rhomax=max(D.rho);
dTmin=min(D.dT);
dTmax=max(D.dT);
Bmin=min(D.B);
Bmax=max(D.B);

TbHat=ObsModel(D,rhoc(1),dTc(1),Bc(1),x);
lfu=sum(log(normpdf(TbHat,TbObs,O.sigTb)));

tic
for i=2:N,
    if mod(i,N/10)==0,
        disp(['Iteration #' num2str(i) '/' num2str(N)])
    end
    %rho
    rhoc(i)=rhoc(i-1)+jmpz(1,i).*jmprho;

    if rhoc(i)<rhomin || rhoc(i)>rhomax,
        rhoc(i)=rhoc(i-1);
    else
        TbHat=ObsModel(D,rhoc(i),dTc(i-1),Bc(i-1),x);
        lfv=sum(log(normpdf(TbHat,TbObs,O.sigTb)));
        lnr= lfv-lfu;
        
        if lnr>log(u(1,i)), %then accept: keep rhoc
            na1=na1+1;
            lfu=lfv;
        else %reject: set rhoc to previous version
            rhoc(i)=rhoc(i-1);
        end    
    end
    
    %dT
    dTc(i)=dTc(i-1)+jmpz(2,i).*jmpdT;
    if dTc(i)<dTmin || dTc(i)>dTmax,
        dTc(i)=dTc(i-1);
    else
        TbHat=ObsModel(D,rhoc(i),dTc(i),Bc(i-1),x);
        lfv=sum(log(normpdf(TbHat,TbObs,O.sigTb)));
        lnr= lfv-lfu;
        
        if lnr>log(u(2,i)), %then accept: keep rhoc
            na2=na2+1;
            lfu=lfv;
        else %reject: set rhoc to previous version
            dTc(i)=dTc(i-1);
        end    
    end

    %B
    Bc(i)=Bc(i-1)+jmpz(3,i).*jmpB;
    if Bc(i)<Bmin || Bc(i)>Bmax,
        Bc(i)=Bc(i-1);
    else
        TbHat=ObsModel(D,rhoc(i),dTc(i),Bc(i),x);
        lfv=sum(log(normpdf(TbHat,TbObs,O.sigTb)));
        lnr= lfv-lfu;
        
        if lnr>log(u(3,i)), %then accept: keep rhoc
            na3=na3+1;
            lfu=lfv;
        else %reject: set rhoc to previous version
            Bc(i)=Bc(i-1);
        end    
    end
end
toc

save(['runs/Exp' num2str(ExpNum) '.mat'])


% Calculate the Gelman and Rubin Potential Scale Reduction Factor for
% convergence inspection
clear
exp10=load('runs/Exp10');
exp11=load('runs/Exp11');

mChainrho(:,:,1)=exp10.rhoc';
mChainrho(:,:,2)=exp11.rhoc';

mChaindT(:,:,1)=exp10.dTc';
mChaindT(:,:,2)=exp11.dTc';

mChainB(:,:,1)=exp10.Bc';
mChainB(:,:,2)=exp11.Bc';

Rrho = psrf(mChainrho);
RdT = psrf(mChaindT);
RB=psrf(mChainB);

exp5=load('runs/Exp5');
exp51=load('runs/Exp51');
exp52=load('runs/Exp52');

mChainrho1(:,:,1)=exp5.rhoc';
mChainrho1(:,:,2)=exp51.rhoc';
mChainrho1(:,:,3)=exp52.rhoc';

mChaindT1(:,:,1)=exp5.dTc';
mChaindT1(:,:,2)=exp51.dTc';
mChaindT1(:,:,3)=exp52.dTc';

mChainB1(:,:,1)=exp5.Bc';
mChainB1(:,:,2)=exp51.Bc';
mChainB1(:,:,3)=exp52.Bc';

Rrho1 = psrf(mChainrho1);
RdT1 = psrf(mChaindT1);
RB1=psrf(mChainB1);


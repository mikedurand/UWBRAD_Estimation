% Calculate the expection based on the estimation result of the MCMC.
% E(x)=delta(x) times frequency of x
% Yuna Duan, April 15th

[Nrho,edgerho]=histcounts(rhoc(iUse));
[NdT,edgedT]=histcounts(dTc(iUse));
[NB,edgeB]=histcounts(Bc(iUse));

Erho=((edgerho(1:end-1)+edgerho(2:end))./2).*(Nrho./length(rhoc));
EdT=((edgedT(1:end-1)+edgedT(2:end))./2).*(NdT./length(dTc));
EB=((edgeB(1:end-1)+edgeB(2:end))./2).*(NB./length(Bc));

Erho=sum(Erho);
EdT=sum(EdT);
EB=sum(EB);
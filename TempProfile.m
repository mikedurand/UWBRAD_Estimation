%function to model ice temperature profile... commented from Jezek's
%original version, by Mike. Modified for Summit
%
% H ice thickness, m
% G geothermal heat flux... W/m2 .047 at Vostok
% M accumulation rate: meters / year, I think
% T surface temperature, K

function [temp,z] = TempProfile(H,G,M,Ts)   

k=2.70;%ice thermal conductivity
K=45;%thermal diffusivity

deltaz=1;
z=[0:deltaz:H];

q=sqrt(M/2/K/H);
coef=G*sqrt(pi)/2/k/q;

erf1=erf(z*q);
erf2=erf(H*q);
Tzb=Ts-coef*(erf1-erf2);

val=size(z);
depthcnt=val(2);
    
for j=1:depthcnt
    temp(j)=Tzb(depthcnt-j+1);
end
    
return
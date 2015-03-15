%function to model ice temperature profile... based on how coded in Jezek's
% paper.
%
% H ice thickness, m
% G geothermal heat flux... W/m2 .047 at Vostok
% M accumulation rate: meters / year, I think
% T surface temperature, K
% z elevation above surface: surface z=0

function [Tzb] = TempProfile2(H,G,M,Ts,z) 

k=2.70;%ice thermal conductivity
K=45;%thermal diffusivity

q=sqrt(M/2/K/H);
b=sqrt(pi)/2/k;

coef=G*b/q;

erf1=erf(z*q);
erf2=erf(H*q);
Tzb=Ts-coef*(erf1-erf2);
    
return
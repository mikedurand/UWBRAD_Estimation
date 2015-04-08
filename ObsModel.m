function Tbi = ObsModel (Data,rhoi,dTi,Bi,x)

for i=1:length(Data.f),
    Tb=squeeze(Data.TbUWBRAD(i,:,:,:,x));
    Tbi(i)=interp3(Data.rho,Data.B,Data.dT,Tb,rhoi,Bi,dTi);
end

return
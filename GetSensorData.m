function [UWBRADSensor] = GetSensorData(fname)

fid=fopen(fname,'r');

fgetl(fid); %first "Far Field" line
fgetl(fid); %comment line

for i=1:181,
    UWBRADSensor.Theta(i)=fscanf(fid,'%f ',1);    
    for j=1:16,
        UWBRADSensor.GaindB(i,j)=fscanf(fid,'%f ',1);    
    end
    fscanf(fid,'\n');
end

fclose(fid);

% UWBRADSensor.Theta=data(:,1);
% UWBRADSensor.GaindB=data(:,2:end);
% UWBRADSensor.Freq=.55:.1:1.95;
UWBRADSensor.Freq=.5:.1:2.0;

return
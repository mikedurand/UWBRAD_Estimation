% Script to integrate the work flow of UWBRAD estimation
% Yuna Duan March 24th based on Mike's seprated scripts

clear 

%% 1. Get UWBRAD Tb

% Average MEMLS Tb by antenna pattern file using function GetModelOutput
% Save result in dat/TbUWBRADrun?
run=1;
GetModelOutput;

%% 2. Generate virtual observation

% Choose random realizations of all parameters, and generate a
% set of observations along the flight lines

GenerateObs;

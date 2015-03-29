% Script to integrate the work flow of UWBRAD estimation
% Yuna Duan March 24th based on Mike's seprated scripts

clear 

%% 1. Get UWBRAD Tb

% Average MEMLS Tb by antenna pattern file using function GetModelOutput
% Save result in dat/TbUWBRAD-v2
% Reorganize the data in the way shown in the numbers sheet
% Save the reorganized results in TbUWBRAD

GetModelOutput;
ReOrganize;

%% 2. Generate virtual observation

% Choose random realizations of all parameters, and generate a
% set of observations along the flight lines

GenerateObs;

%% 3. Estimate Temperature
%  Calculate MCMC estimate of temperature parameters (~4 minute
%  run-time per location). Saves dat/Expi.mat, where i=0,1,2...

ExpNum=5;
O=load('dat/TbObs.mat');
D=load('dat/TbUWBRAD.mat');
EstimateT;

%% 4.PostProcess
% Explores the MCMC output via figures, including the final
% estimated temperature profiles

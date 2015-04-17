% Script to estimation temperature along the flight line

% Yuna Duan April 15th 
%% 1. Get UWBRAD Tb

% Average MEMLS Tb by antenna pattern file using function GetModelOutput
% Save result in dat/TbUWBRAD-v2
% Reorganize the data in the way shown in the numbers sheet
% Save the reorganized results in TbUWBRAD
clear 
RecalculateTb=true;

if RecalculateTb
    GetModelOutput;
    ReOrganize;
end
%% 2. Generate virtual observation

% Choose random realizations of all parameters, and generate a
% set of observations along the flight lines
RenerateObs=true;

if RenerateObs
    GenerateObs;
end
%% 3. Estimate Temperature
%  Calculate MCMC estimate of temperature parameters (~4 minute
%  run-time per location). Saves dat/Expi.mat, where i=0,1,2...
%  Change ExpNum and interation# N to adjust the estimation
O=load('dat/TbObs.mat');
D=load('dat/TbUWBRAD.mat');

for x=1:47 %location 1-47 to estimate
    disp(['Estimating point' num2str(x)])
    ExpNum=x+6;
    N=5E4; %MCMC iterations
    EstimateT;
end




<<<<<<< HEAD
% Script to integrate the work flow of UWBRAD estimation
=======
% Script to integrate the work flow of UWBRAD temperature estimation
>>>>>>> pr/3
% Yuna Duan March 24th based on Mike's seprated scripts

%% 1. Get UWBRAD Tb

% Average MEMLS Tb by antenna pattern file using function GetModelOutput
% Save result in dat/TbUWBRAD-v2
% Reorganize the data in the way shown in the numbers sheet
% Save the reorganized results in TbUWBRAD
<<<<<<< HEAD
=======

>>>>>>> pr/3
clear 
RecalculateTb=false;

if RecalculateTb
    GetModelOutput;
    ReOrganize;
end
%% 2. Generate virtual observation

% Choose random realizations of all parameters, and generate a
% set of observations along the flight lines
<<<<<<< HEAD
RenerateObs=false;
=======

RenerateObs=true;
>>>>>>> pr/3
if RenerateObs
    GenerateObs;
end
%% 3. Estimate Temperature
%  Calculate MCMC estimate of temperature parameters (~4 minute
%  run-time per location). Saves dat/Expi.mat, where i=0,1,2...
%  Change ExpNum and interation# N to adjust the estimation
<<<<<<< HEAD
x=15; %location 1-47 to estimate
ExpNum=521;
N=1E3; %MCMC iterations
=======

x=15; %location 1-47 to estimate
ExpNum=12;%experiment index
N=5E4; %MCMC iterations
>>>>>>> pr/3
O=load('dat/TbObs.mat');
D=load('dat/TbUWBRAD.mat');
EstimateT;

<<<<<<< HEAD
%% 4.PostProcess
% Explores the MCMC output via figures, including the final
% estimated temperature profiles
PostProcess;
=======
%% 4. PostProcess
% Explores the MCMC output via figures, including the final
% estimated temperature profiles
PostProcess;
>>>>>>> pr/3

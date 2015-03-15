%% Scripts
%  ~WORKFLOW SCRIPTS~
% GetModelOutput: Rework MEMLS runs into a 
% GenerateObs: Choose random realizations of all parameters, and generate a
%     set of observations along the flight lines
% EstimateT: Calculate MCMC estimate of temperature parameters (~4 minute
%     run-time per location). Saves dat/Expi.mat, where i=0,1,2...
% PostProcess: Explores the MCMC output via figures, including the final
%     estimated temperature profiles
% 
% ~UTILITY SCRIPTS~
% GetSensorData
% ObsModel: Interpolates between model data as a way of exploring parameter
%     space

%% Data
% dat/ includes the MEMLS database of model runs

%% Experiments
%dat/Exp0 ~ x=15, N=1E4
%dat/Exp1 ~ x=15, N=1E5
%dat/Exp2 ~ x=20, N=1E5
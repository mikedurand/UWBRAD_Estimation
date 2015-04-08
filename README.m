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

% ~ Add By Yuna ~
%ACF_k: calculate the autocorrelation of the Markov chain
%psrf: calculate the Gelman and Rubin Potential Scale Reduction Factor
%% Data
% dat/ includes the MEMLS database of model runs

%% Experiments

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
<<<<<<< HEAD
%dat/Exp0 ~ x=15, N=1E4
%dat/Exp1 ~ x=15, N=1E5
%dat/Exp2 ~ x=20, N=1E5

%---------experiment of Yuna-----------------
%All experiments use newly generated TbMEMLS, which fixed the wrong
%temperature profile

%dat/Exp5 ~ x=15, N=1E4, Elapsed time is 192.280114 seconds.
%The result varies hugely everytime. The MCMC does not seem to reach to a 
%steady-state distribution.

%dat/Exp51 ~ x=15, N=1E4
%dat/Exp52 ~ x=15, N=1E4

%dat/Exp6 ~ x=15, N=1E5, Elapsed time is 1989.567482 seconds.

%dat/Exp7 ~ x=15, N=1E5
%Repeat the Exp6 to see if the result of Exp6 is reprodutive
%Sadly, the answer seems to be, no. 
=======
>>>>>>> pr/3

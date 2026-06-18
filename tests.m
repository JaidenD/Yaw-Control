clear;
clc;
close all;

savePlots = true;
%% Load model parmas
vehicle_params;

%% Control params

% ---------------------------------------------------------
% Sideslip correction thresholds
% ---------------------------------------------------------
beta_act = deg2rad(1.5);  % sideslip activation threshold [rad]
beta_th  = deg2rad(6);  % sideslip upper threshold [rad]
k1 = 1.0;               % correction gain in transition region [-]
k2 = 1.0;               % correction gain above threshold [-]
Delta_a_y_gain = 0.1;    % tuning parameter for sideslip correction [-]

% ---------------------------------------------------------
% High-level yaw moment controller
% ---------------------------------------------------------
Kp = 3000;      % yaw-rate proportional gain [N*m/(rad/s)]
Ki = 5000;      % yaw-rate integral gain [N*m/rad]
Mz_max = 4000;  % max direct yaw moment [N*m]

% ---------------------------------------------------------
% Steering input
% ---------------------------------------------------------
delta_final = 0.05;     % steering step amplutide [rad]
delta_step_time = 1;    % steering step time [s]


% load model
model = 'plantModel';
load_system(model);

%% Case A: Passive
passive = 1;
use_sideslip_correction = 0; % irrelevant here
out_passive = sim(model);
plot_results(out_passive, "passive", savePlots)

%% Case B: yaw rate only torque vectoring
passive = 0;
use_sideslip_correction = 0;
out_yaw_only = sim(model);
plot_results(out_yaw_only, "yawOnly", savePlots)

%% Case C: sideslip-corrected torque vectoring
passive = 0;
use_sideslip_correction = 1;
out_corrected = sim(model);
plot_results(out_corrected, "full", savePlots)

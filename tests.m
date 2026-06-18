%% tests.m
% Runs passive, yaw-rate-only, and sideslip-corrected torque-vectoring cases.

clear;
clc;
close all;

savePlots = true;

%% Load base vehicle/model parameters
vehicle_params;

%% Override / define controller and test parameters

% Sideslip correction thresholds
beta_act = deg2rad(10);   % [rad]
beta_th  = deg2rad(6);     % [rad]
k1 = 1.0;
k2 = 1.0;
Delta_a_y_gain = 0.1;

% High-level yaw moment controller
Kp = 3000;
Ki = 5000;
Mz_max = 4000;

% Steering input
delta_final = 0.05;        % [rad]
delta_step_time = 1;       % [s]

%% Load model
model = 'plantModel';
load_system(model);
set_param(model, 'FastRestart', 'off');

%% Case A: Passive vehicle
passive = 1;
use_sideslip_correction = 0;

out_passive = sim(model);
plot_results(out_passive, "passive", savePlots);

%% Case B: Yaw-rate-only torque vectoring
passive = 0;
use_sideslip_correction = 0;

out_yaw_only = sim(model);
plot_results(out_yaw_only, "yawOnly", savePlots);

%% Case C: Sideslip-corrected torque vectoring
passive = 0;
use_sideslip_correction = 1;

out_corrected = sim(model);
plot_results(out_corrected, "full", savePlots);
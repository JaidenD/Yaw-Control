%% tests.m
% Runs passive, yaw-rate-only, and sideslip-corrected torque-vectoring cases.

clear;
clc;
close all;

savePlots = true;

%% Load base vehicle/model parameters
vehicle_params;

% Sideslip correction thresholds
beta_act = deg2rad(0.05);   % [rad]
beta_th  = deg2rad(1.0);     % [rad]
k1 = 1.0;
k2 = 1.0;
Delta_a_y_gain = 0.4;

% High-level controller
Kp = 3000;
Ki = 5000;
Mz_max = 4000;

% Steering input
t_delta = [0 1 3.5 6 8.5 11 14]';
delta_values = [0 0.08 -0.08 0.09 -0.09 0 0]';

delta_in = timeseries(delta_values, t_delta);

%% Load model
model = 'plantModel';
load_system(model);
set_param(model, 'FastRestart', 'off');
set_param(model, 'StopTime', '14');

%% Case A: Passive
passive = 1;
use_sideslip_correction = 0;

out_passive = sim(model);

%% Case B: Yaw-rate-only
passive = 0;
use_sideslip_correction = 0;

out_yaw_only = sim(model);

%% Case C: Sideslip-corrected
passive = 0;
use_sideslip_correction = 1;

out_corrected = sim(model);

%% Combined plots
plot_comparison_results(out_passive, out_yaw_only, out_corrected, delta_in, savePlots);

%% Local helper function: combined plots
function plot_comparison_results(out_passive, out_yaw_only, out_corrected, delta_in, savePlots)

    close all;

    %% Passive logs
    logsP = out_passive.logsout;
    betaP = logsP.get('beta').Values;
    rP    = logsP.get('r').Values;
    ayP   = logsP.get('ay').Values;
    MzP   = logsP.get('M_z').Values;
    tauLP = logsP.get('tauL').Values;
    tauRP = logsP.get('tauR').Values;
    %deltaP = logsP.get('delta').Values;

    %% Yaw-only logs
    logsY = out_yaw_only.logsout;
    betaY = logsY.get('beta').Values;
    rY    = logsY.get('r').Values;
    ayY   = logsY.get('ay').Values;
    MzY   = logsY.get('M_z').Values;
    tauLY = logsY.get('tauL').Values;
    tauRY = logsY.get('tauR').Values;

    %% Sideslip logs
    logsF = out_corrected.logsout;
    betaF = logsF.get('beta').Values;
    rF    = logsF.get('r').Values;
    ayF   = logsF.get('ay').Values;
    MzF   = logsF.get('M_z').Values;
    tauLF = logsF.get('tauL').Values;
    tauRF = logsF.get('tauR').Values;

    %% Figure 1
    fig1 = figure;

    subplot(3,1,1);
    plot(betaP.Time, rad2deg(betaP.Data), 'LineWidth', 1.5); hold on;
    plot(betaY.Time, rad2deg(betaY.Data), 'LineWidth', 1.5);
    plot(betaF.Time, rad2deg(betaF.Data), 'LineWidth', 1.5);
    grid on;
    xlabel('Time [s]');
    ylabel('Sideslip angle \beta [deg]');
    legend('Passive', 'Yaw-rate only', 'Sideslip corrected', 'Location', 'best');
    title('(a) Sideslip Angle');

    subplot(3,1,2);
    plot(rP.Time, rad2deg(rP.Data), 'LineWidth', 1.5); hold on;
    plot(rY.Time, rad2deg(rY.Data), 'LineWidth', 1.5);
    plot(rF.Time, rad2deg(rF.Data), 'LineWidth', 1.5);
    grid on;
    xlabel('Time [s]');
    ylabel('Yaw rate [deg/s]');
    legend('Passive', 'Yaw-rate only', 'Sideslip corrected', 'Location', 'best');
    title('(b) Yaw Rate');

    subplot(3,1,3);
    plot(ayP.Time, ayP.Data, 'LineWidth', 1.5); hold on;
    plot(ayY.Time, ayY.Data, 'LineWidth', 1.5);
    plot(ayF.Time, ayF.Data, 'LineWidth', 1.5);
    grid on;
    xlabel('Time [s]');
    ylabel('Lateral acceleration a_y [m/s^2]');
    legend('Passive', 'Yaw-rate only', 'Sideslip corrected', 'Location', 'best');
    title('(c) Lateral Acceleration');

    sgtitle('Comparison of Passive, Yaw-Rate-Only, and Sideslip-Corrected Control');

    %% Figure 2
    fig2 = figure;

    subplot(3,1,1);
    plot(MzP.Time, MzP.Data, 'LineWidth', 1.5); hold on;
    plot(MzY.Time, MzY.Data, 'LineWidth', 1.5);
    plot(MzF.Time, MzF.Data, 'LineWidth', 1.5);
    grid on;
    xlabel('Time [s]');
    ylabel('M_z [N m]');
    legend('Passive', 'Yaw-rate only', 'Sideslip corrected', 'Location', 'best');
    title('(a) Direct Yaw Moment');

    subplot(3,1,2);
    plot(tauLP.Time, tauLP.Data, 'LineWidth', 1.5); hold on;
    plot(tauLY.Time, tauLY.Data, 'LineWidth', 1.5);
    plot(tauLF.Time, tauLF.Data, 'LineWidth', 1.5);
    grid on;
    xlabel('Time [s]');
    ylabel('\tau_L [N m]');
    legend('Passive', 'Yaw-rate only', 'Sideslip corrected', 'Location', 'best');
    title('(b) Left-Side Wheel Torque');

    subplot(3,1,3);
    plot(tauRP.Time, tauRP.Data, 'LineWidth', 1.5); hold on;
    plot(tauRY.Time, tauRY.Data, 'LineWidth', 1.5);
    plot(tauRF.Time, tauRF.Data, 'LineWidth', 1.5);
    grid on;
    xlabel('Time [s]');
    ylabel('\tau_R [N m]');
    legend('Passive', 'Yaw-rate only', 'Sideslip corrected', 'Location', 'best');
    title('(c) Right-Side Wheel Torque');

    sgtitle('Control Effort Comparison');

    %% Figure 3
    fig3 = figure;
    plot(delta_in.Time, delta_in.Data, 'LineWidth', 1.5);
    grid on;
    xlabel('Time [s]');
    ylabel('Steering angle \delta [rad]');
    title('Steering Input');
    %% Save
    if savePlots
        folderName = 'comparisonPlots';

        if ~exist(folderName, 'dir')
            mkdir(folderName);
        end

        saveas(fig1, fullfile(folderName, 'fig_comparison_beta_yaw_ay.png'));
        saveas(fig2, fullfile(folderName, 'fig_comparison_control_effort.png'));
        saveas(fig3, fullfile(folderName, 'fig_steering_input.png'));
    end

end
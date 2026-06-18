function plot_results(out, caseName, savePlots)

close all;

%% Extract logs
logsout = out.logsout;

M_z   = logsout.get('M_z').Values;
r_ref = logsout.get('r_ref').Values;
delta = logsout.get('delta').Values;
ay    = logsout.get('ay').Values;
beta  = logsout.get('beta').Values;
r     = logsout.get('r').Values;
tauL  = logsout.get('tauL').Values;
tauR  = logsout.get('tauR').Values;

%% Figure 1: Steering input
fig1 = figure;
plot(delta.Time, rad2deg(delta.Data), 'LineWidth', 1.5);
grid on;
xlabel('Time [s]');
ylabel('Steering angle \delta [deg]');
title(sprintf('Steering Input (%s)', caseName));

%% Figure 2: Yaw-rate tracking
fig2 = figure;
plot(r_ref.Time, r_ref.Data, 'LineWidth', 1.5); hold on;
plot(r.Time, r.Data, 'LineWidth', 1.5);
grid on;
xlabel('Time [s]');
ylabel('Yaw rate [rad/s]');
legend('r_{ref}', 'r', 'Location', 'best');
title(sprintf('Yaw-Rate Tracking (%s)', caseName));

%% Figure 3: Yaw-rate tracking error
r_ref_interp = interp1(r_ref.Time, r_ref.Data, r.Time, 'linear', 'extrap');
e_r = r_ref_interp - r.Data;

fig3 = figure;
plot(r.Time, e_r, 'LineWidth', 1.5);
grid on;
xlabel('Time [s]');
ylabel('Yaw-rate error [rad/s]');
title(sprintf('Yaw-Rate Tracking Error (%s)', caseName));

%% Figure 4: Sideslip angle
fig4 = figure;
plot(beta.Time, rad2deg(beta.Data), 'LineWidth', 1.5);
grid on;
xlabel('Time [s]');
ylabel('Sideslip angle \beta [deg]');
title(sprintf('Vehicle Sideslip Angle (%s)', caseName));

%% Figure 5: Lateral acceleration
fig5 = figure;
plot(ay.Time, ay.Data, 'LineWidth', 1.5);
grid on;
xlabel('Time [s]');
ylabel('Lateral acceleration a_y [m/s^2]');
title(sprintf('Lateral Acceleration (%s)', caseName));

%% Figure 6: Direct yaw moment command
fig6 = figure;
plot(M_z.Time, M_z.Data, 'LineWidth', 1.5);
grid on;
xlabel('Time [s]');
ylabel('Direct yaw moment M_z [N m]');
title(sprintf('High-Level Controller Output (%s)', caseName));

%% Figure 7: Wheel torque allocation
fig7 = figure;
plot(tauL.Time, tauL.Data, 'LineWidth', 1.5); hold on;
plot(tauR.Time, tauR.Data, 'LineWidth', 1.5);
grid on;
xlabel('Time [s]');
ylabel('Wheel torque [N m]');
legend('\tau_L', '\tau_R', 'Location', 'best');
title(sprintf('Left/Right Torque Allocation (%s)', caseName));

%% Save plots
if savePlots

    caseNameSafe = matlab.lang.makeValidName(char(caseName));
    folderName = [caseNameSafe 'Plots'];

    if ~exist(folderName, 'dir')
        mkdir(folderName);
    end

    saveas(fig1, fullfile(folderName, sprintf('fig_steering_input_%s.png', caseNameSafe)));
    saveas(fig2, fullfile(folderName, sprintf('fig_yaw_rate_tracking_%s.png', caseNameSafe)));
    saveas(fig3, fullfile(folderName, sprintf('fig_yaw_rate_error_%s.png', caseNameSafe)));
    saveas(fig4, fullfile(folderName, sprintf('fig_sideslip_angle_%s.png', caseNameSafe)));
    saveas(fig5, fullfile(folderName, sprintf('fig_lateral_acceleration_%s.png', caseNameSafe)));
    saveas(fig6, fullfile(folderName, sprintf('fig_direct_yaw_moment_%s.png', caseNameSafe)));
    saveas(fig7, fullfile(folderName, sprintf('fig_wheel_torques_%s.png', caseNameSafe)));

end

end
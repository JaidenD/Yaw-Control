function plot_results(out, caseName, savePlots)

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
figure;
plot(delta.Time, rad2deg(delta.Data), 'LineWidth', 1.5);
grid on;
xlabel('Time [s]');
ylabel('Steering angle \delta [deg]');
title('Steering Input (%s)', caseName);

%% Figure 2: Yaw-rate tracking
figure;
plot(r_ref.Time, r_ref.Data, 'LineWidth', 1.5); hold on;
plot(r.Time, r.Data, 'LineWidth', 1.5);
grid on;
xlabel('Time [s]');
ylabel('Yaw rate [rad/s]');
legend('r_{ref}', 'r', 'Location', 'best');
title('Yaw-Rate Tracking');

%% Figure 3: Yaw-rate tracking error
% Interpolate r_ref onto r time-grid if needed
r_ref_interp = interp1(r_ref.Time, r_ref.Data, r.Time, 'linear', 'extrap');
e_r = r_ref_interp - r.Data;

figure;
plot(r.Time, e_r, 'LineWidth', 1.5);
grid on;
xlabel('Time [s]');
ylabel('Yaw-rate error [rad/s]');
title('Yaw-Rate Tracking Error (%s)', caseName);

%% Figure 4: Sideslip angle
figure;
plot(beta.Time, rad2deg(beta.Data), 'LineWidth', 1.5);
grid on;
xlabel('Time [s]');
ylabel('Sideslip angle \beta [deg]');
title('Vehicle Sideslip Angle (%s)', caseName);

%% Figure 5: Lateral acceleration
figure;
plot(ay.Time, ay.Data, 'LineWidth', 1.5);
grid on;
xlabel('Time [s]');
ylabel('Lateral acceleration a_y [m/s^2]');
title('Lateral Acceleration (%s)', caseName);

%% Figure 6: Direct yaw moment command
figure;
plot(M_z.Time, M_z.Data, 'LineWidth', 1.5);
grid on;
xlabel('Time [s]');
ylabel('Direct yaw moment M_z [N m]');
title('High-Level Controller Output (%s)', caseName);

%% Figure 7: Wheel torque allocation
figure;
plot(tauL.Time, tauL.Data, 'LineWidth', 1.5); hold on;
plot(tauR.Time, tauR.Data, 'LineWidth', 1.5);
grid on;
xlabel('Time [s]');
ylabel('Wheel torque [N m]');
legend('\tau_L', '\tau_R', 'Location', 'best');
title('Left/Right Torque Allocation, (%s)', caseName);

if savePlots

folderName = caseName + 'Plots';

if ~exist(folderName, 'dir')
    mkdir(folderName);
end

caseNameSafe = matlab.lang.makeValidName(char(caseName));

saveas(1, fullfile(folderName, sprintf('fig_steering_input_%s.png', caseNameSafe)));
saveas(2, fullfile(folderName, sprintf('fig_yaw_rate_tracking_%s.png', caseNameSafe)));
saveas(3, fullfile(folderName, sprintf('fig_yaw_rate_error_%s.png', caseNameSafe)));
saveas(4, fullfile(folderName, sprintf('fig_sideslip_angle_%s.png', caseNameSafe)));
saveas(5, fullfile(folderName, sprintf('fig_lateral_acceleration_%s.png', caseNameSafe)));
saveas(6, fullfile(folderName, sprintf('fig_direct_yaw_moment_%s.png', caseNameSafe)));
saveas(7, fullfile(folderName, sprintf('fig_wheel_torques_%s.png', caseNameSafe)));

end

end
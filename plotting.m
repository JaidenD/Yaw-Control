%% plot_results.m
% Plot logged Simulink signals from plantModel.
% Assumes simulation output variable is named "out".

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
figure;
plot(delta.Time, rad2deg(delta.Data), 'LineWidth', 1.5);
grid on;
xlabel('Time [s]');
ylabel('Steering angle \delta [deg]');
title('Steering Input');

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
title('Yaw-Rate Tracking Error');

%% Figure 4: Sideslip angle
figure;
plot(beta.Time, rad2deg(beta.Data), 'LineWidth', 1.5);
grid on;
xlabel('Time [s]');
ylabel('Sideslip angle \beta [deg]');
title('Vehicle Sideslip Angle');

%% Figure 5: Lateral acceleration
figure;
plot(ay.Time, ay.Data, 'LineWidth', 1.5);
grid on;
xlabel('Time [s]');
ylabel('Lateral acceleration a_y [m/s^2]');
title('Lateral Acceleration');

%% Figure 6: Direct yaw moment command
figure;
plot(M_z.Time, M_z.Data, 'LineWidth', 1.5);
grid on;
xlabel('Time [s]');
ylabel('Direct yaw moment M_z [N m]');
title('High-Level Controller Output');

%% Figure 7: Wheel torque allocation
figure;
plot(tauL.Time, tauL.Data, 'LineWidth', 1.5); hold on;
plot(tauR.Time, tauR.Data, 'LineWidth', 1.5);
grid on;
xlabel('Time [s]');
ylabel('Wheel torque [N m]');
legend('\tau_L', '\tau_R', 'Location', 'best');
title('Left/Right Torque Allocation');

saveas(1, 'fig_steering_input.png');
saveas(2, 'fig_yaw_rate_tracking.png');
saveas(3, 'fig_yaw_rate_error.png');
saveas(4, 'fig_sideslip_angle.png');
saveas(5, 'fig_lateral_acceleration.png');
saveas(6, 'fig_direct_yaw_moment.png');
saveas(7, 'fig_wheel_torques.png');
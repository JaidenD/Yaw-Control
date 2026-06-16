% Run this to configure sytsem params

% ---------------------------------------------------------
% Vehicle inertial params
% ---------------------------------------------------------
m = 1500;       % vehicle mass [kg]
Iz = 2500;      % yaw moment of inertia [kg*m^2]

% ---------------------------------------------------------
% Geometry
% ---------------------------------------------------------
a = 1.2;        % distance from CG to front axel [m]
b = 1.6;        % distance from CG to rear axel [m]
L = a + b;      % Wheel base [m]

d = 0.75;       % half-track width [m]
Rw = 0.30;      % wheel radius [m]

% ---------------------------------------------------------
% Tire params
% ---------------------------------------------------------
Caf = 80000;     % front axel cornering siffness [N/rad]
Car = 80000;     % rear axel cornering siffness [N/rad]

% ---------------------------------------------------------
% Operating condition
% ---------------------------------------------------------
Vx = 20;        % constant longitudinal speed [m/s]
mu = 0.6;       % tire-road friction coef
g = 9.81;       % gravitational acceleration [m/s]

% ---------------------------------------------------------
% Reference yaw-rate generator
% ---------------------------------------------------------
kh = 1.2;       % handling yaw-rate aggressiveness gain [-]

% ---------------------------------------------------------
% Sideslip correction thresholds
% ---------------------------------------------------------
beta_act = deg2rad(3);  % sideslip activation threshold [rad]
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
% Simulation settings
% ---------------------------------------------------------
Tsim = 10;      % simulation time [s]
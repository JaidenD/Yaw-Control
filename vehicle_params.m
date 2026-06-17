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
% Simulation settings
% ---------------------------------------------------------
Tsim = 10;      % simulation time [s]
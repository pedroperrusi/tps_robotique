%%%%%%%%%%%%%% INIT %%%%%%%%%%%%%%

close all
clear all
clc

global S; global C;
global Ss; global Cs;
global rh;
rh=0.12; % head radius
rr=2*rh; %robot_radius
n_points=20;

xT=0.57;yT=0; zT=0.57;
pT=[xT,yT,zT]; % head centre position wrt to Fb reference system


%%%%%%%%%%%%%% TRANSFORMATION b->0 %%%%%%%%%%%%%%

s0=pi/4;C0=cos(s0);S0=sin(s0);
%% Robot structure options
s_options = zeros(2, 3);
% Configuration 1
s_options(:, 1) = ones(2, 1)*pi/2;
% Configuration 2
s_options(:, 2) = [2; 1]*pi/3;
% simmetric arcs
% s0 + s(1) + s(2) must be pi
s_options(:, 3) = ones(2, 1)*(pi - s0)/2;
% Choose an index
s = s_options(:, 2);

Cs=cos(s);Ss=sin(s);

Rb0=[0,0,1;-1,0,0;0,-1,0]*[1,0,0;0,C0,-S0;0,S0,C0]; % rotation matrix
pb0=[xT;yT;zT]; % translation in the head centre
Tb0=[Rb0,pb0;0,0,0,1]; % transformation matrix

%% Waypoints Computation
close all;
% Compute IKM waypoints for the upper part of the head
% phi = 0; theta = 0 : pi;
disp('Plotting the inverse kinematic for an upper head scan')
num_points = 30;
arc_length = pi;
arc_offset = -pi/2;
arc_step = arc_length/num_points;
phis = zeros(1, num_points);
thetas = (0 : num_points) * arc_step + arc_offset;
q_table = zeros(3, num_points);
x_table = zeros(3, num_points);
for i = 1 : num_points
    x_table(:, i) = [rh*sin(thetas(i))*cos(phis(i));...
                     rh*sin(thetas(i))*sin(phis(i));...
                     rh*cos(thetas(i))];
    [q, ~] = ikm(x_table(:, i));
    q_table(:, i) = q;
    draw_scene
%     pause
end
table = [x_table; q_table];

%% On analyse le jacobian pour chaque position du OT         
% compute the force vector for the EF along the trajectory
g = 9.8;  % m/s^2
f = [0; 0; 3] .* g;
torque_table = zeros(3, num_points);
for i = 1 : num_points
    % compute the jacobian for this joint configuration
    [J, Jg] = jacobian(q_table(:, i));
    torque_table(:, i) = J' * f;
end
table = [table; torque_table];

%% INIT

close all
clear all
clc

rr=0.2; % robot_radius
rh=0.12; % head radius
l3=0.18; % link3 length
n_points=100;

% head centre position wrt to Fb reference system
xT=0.57;yT=0; zT=0.57;pT=[xT,yT,zT];

%% PLOTS
%% Plot head
colormap([1, 0.75, 0.79])
[x,y,z]=sphere;

surf(xT+rh*x,rh*y,zT+rh*z)

alpha(0.4)
shading interp


box on
grid on
view([0,-1,0]);
rotate3d on

%% Plot robot
% Robot State
q1 = pi/2;
q2 = -pi/2;
q3 = 0;
q = [q1; q2; q3];
plot_robot(q, pT, rr, l3)

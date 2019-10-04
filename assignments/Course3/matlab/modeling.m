%% INIT

close all
clear all
clc

% Load TMS robot constants
tms_constants


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
q1 = 0;
q2 = 0;
q3 = 0;
q = [q1; q2; q3];
plot_tms(q, pT, rr, l3)

%% Kinematics Modeling
effector_position = fkm(q)
joints = ikm(effector_position)
plot3(effector_position(1), effector_position(2), effector_position(3), 'ro','MarkerSize',15)

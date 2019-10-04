%% INIT

close all
clear all
clc

% Load TMS robot constants
tms_constants

%% Plot robot
% random inputs
rng = @(min, max) (max - min) * rand(1,1) + min;
% Robot State
q1 = rng(pi, -pi);
q2 = rng(pi, -pi);
q3 = 0;
q = [q1; q2; q3];
figure;
plot_tms(q, pT, rr, l3, 'r-', 'y-')

%% Kinematics Modeling
effector_position = fkm(q);
joints = ikm(effector_position);

%% Print
disp('Joint position:')
disp(q')
disp('fkm:')
disp(effector_position)
disp('ikm:')
disp(joints)
figure
plot_tms(joints(1,:), pT, rr, l3, 'r--', 'y--')
plot_tms(joints(2,:), pT, rr, l3, 'b--', 'g--')

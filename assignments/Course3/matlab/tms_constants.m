%% Load TMS Constants

rr=0.2; % robot_radius
rh=0.12; % head radius
l3=0.18; % link3 length

% head centre position wrt to Fb reference system
xT=0.57;yT=0; zT=0.57;pT=[xT,yT,zT];

% Base link
% - frame rotation from z to z' around z
alpha0 = pi/2;
Ca0 = cos(alpha0);
Sa0 = sin(alpha0);
% - angle between x and x'
s0 = pi/3; 
Cs0 = cos(s0);
Ss0 = sin(s0);
% Joint 1 and Joint 2
s1 = 2*pi/3; 
Cs1 = cos(s1);
Ss1 = sin(s1);
% Joint 2 and Joint 3
s2 = pi/3; 
Cs2 = cos(s2);
Ss2 = sin(s2);
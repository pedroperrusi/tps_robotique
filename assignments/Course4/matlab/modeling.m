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
s=[pi/2,pi/3];
Cs=cos(s);Ss=sin(s);

Rb0=[0,0,1;-1,0,0;0,-1,0]*[1,0,0;0,C0,-S0;0,S0,C0]; % rotation matrix
pb0=[xT;yT;zT]; % translation in the head centre
Tb0=[Rb0,pb0;0,0,0,1]; % transformation matrix
    

%%%%%%%%%%%%%% MODELS CALLS %%%%%%%%%%%%%%

%%%%%%%%%%%%%% FKM %
             
q=[pi/2*(1-2*rand(1)),pi/2*(1-2*rand(1)),rh*(1-2*rand(1))];
disp('********Configuration**********')

if ( (le(q(3),rh-rr) || ge(q(3),rh)) == 1 )
bounds=strcat('The robot joint range should be chosen such that 0<d(O_0,O_4)<rr which is equivalent to:',num2str(rh-rr),'<q3<',num2str(rh));
error(bounds)
end

disp('  q=')
disp(q)

[rot,pos]=fkm(q);
b_pos=Tb0*[pos';1];
b_pos=b_pos(1:3)';
disp('************FKM****************')
disp('O4 position in Fb:')
disp('  x=          y=       z=   ')
disp(b_pos);
disp('*******************************')

%%%%%%%%%%%%%% END FKM %

% pause

%%%%%%%%%%%%%% IKM %%%%%%%%%%%%%%%%

disp('')
disp('************IKM****************')

% Call the IKM to find the 2 solutions to the IKM
[q_sol1, q_sol2] = ikm(pos);
% Debug the IKM 
disp('************IKM****************')
disp('Q positions to reach O4')
disp('Solution 1: q = ')
disp(q_sol1);
disp('Solution 2: q = ')
disp(q_sol2);
disp('*******************************')


%%%%%%%%%%%%%% Jacobian %%%%%%%%%%%%%%%%

disp('')
disp('**********Jacobian**************')

% call the jacobian function, that should provide two matrices
% [J,Jg]=jacobian(q)

% Find a way to debug the Jacobian and check your solutions

disp('')
disp('**********End Jacobian**************')

%%%%%%%%%%%%%% PLOTS %%%%%%%%%%%%%%

draw_scene

%%%%%%%%%%%%%% INIT %%%%%%%%%%%%%%

close all
clear all
clc

rr=0.2; % robot_radius
rh=0.12; % head radius
l3=0.18; % link3 length
n_points=100;

% head centre position wrt to Fb reference system
xT=0.57;yT=0; zT=0.57;pT=[xT,yT,zT];

%%%%%%%%%%%%%% TRANSFORMATIONS %%%%%%%%%%%%%%
%% Constants
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

%% Joint State
% joint 1 (revolute)
q1 = pi/2;
C1 = cos(q1);
S1 = sin(q1);
% joint 2 (revolute)
q2 = -pi/2;
C2 = cos(q2);
S2 = sin(q2);
% joint 3 (tranlational)
q3 = 0;
%% Base to link 0
% rotation is composed of pi/2 around x axis and s0 around z'
Rb0 = [1 0 0; 0 Ca0 -Sa0; 0 Sa0 Ca0] * [Cs0 -Ss0 0; Ss0 Cs0 0; 0 0 1];
pb0 = [0.3; 0; 0]; % 300mm
Tb0= [Rb0 pb0; 0 0 0 1];
    
%% joint 1 (revolute)
R01= [C1 -S1 0;S1 C1 0; 0 0 1];
p01= pT';
T01= [R01 p01; 0 0 0 1];
% base to joint 1
% Tb1 = Tb0 * T01;
Tb1 = T01;
    
%% joint 2 (revolute)
R12= [C2 -S2 0; Cs1*S2 Cs1*C2 Ss1; -Ss1*S2 -Ss1*C2 Cs1];
p12= [0; 0; 0];
T12= [R12 p12; 0 0 0 1];
Tb2= Tb1 * T12;

%% joint 3 (tranlational)
R23= [1 0 0; 0 Cs2 Ss2; 0 -Ss2 Cs2];
p23= [0; q3*Ss2; q3*Cs2];
T23= [R23 p23; 0 0 0 1];
Tb3= Tb2 * T23;

%%%%%%%%%%%%%% PLOTS %%%%%%%%%%%%%%

%% Plots
hold on 
axis([0 xT+1.5*rr,yT-1.5*rr,yT+1.5*rr,0,zT+2*rr])
xlabel('x');ylabel('y');zlabel('z')

line([0,xT],[0 yT],[0,zT],'LineWidth',2,'LineStyle','--','Color','k')

plot3(xT,yT,zT,'bo','MarkerSize',5, 'MarkerFaceColor','r')
plot3(xT-rr*Tb1(1,3),yT-rr*Tb1(2,3),zT-rr*Tb1(3,3),'co','MarkerSize',12, 'MarkerFaceColor','k')
plot3(xT-rr*Tb2(1,3),yT-rr*Tb2(2,3),zT-rr*Tb2(3,3),'co','MarkerSize',12, 'MarkerFaceColor','k')
plot3(xT-rr*Tb3(1,3),yT-rr*Tb3(2,3),zT-rr*Tb3(3,3),'co','MarkerSize',12, 'MarkerFaceColor','k') 
plot3(xT-rr*Tb3(1,3),yT-rr*Tb3(2,3),zT-rr*Tb3(3,3),'bo','MarkerSize',15)

circular_arc(pT,rr,0,s1,Tb1,'r-')
circular_arc(pT,rr,0,s2,Tb2,'y-')
line([xT+(q3-l3)*Tb3(1,3) xT+(q3)*Tb3(1,3)], ...
    [yT+(q3-l3)*Tb3(2,3) yT+(q3)*Tb3(2,3)], ...
    [zT+(q3-l3)*Tb3(3,3) zT+(q3)*Tb3(3,3)],...
    'Color',[0.6 0.6 0.6],'LineStyle','-','LineWidth',5)



colormap([1, 0.75, 0.79])
[x,y,z]=sphere;

surf(xT+rh*x,rh*y,zT+rh*z)

alpha(0.4)
shading interp


box on
grid on
view([0,-1,0]);
rotate3d on

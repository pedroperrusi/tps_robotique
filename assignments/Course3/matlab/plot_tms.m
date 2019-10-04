function plot_tms( q, pT, rr, l3 )
%PLOT_ROBOT Draw robot axis for a given joint state q
%   Receives the joint state q, the head center position pT,
%   the robot sphere radius, the end effector length l3 and
%   number of points n_points.

% Head Position
xT = pT(1);
yT = pT(2);
zT = pT(3);
% Load TMS constants from script
tms_constants

%% Joint State
% joint 1 (revolute)
q1 = q(1);
C1 = cos(q1);
S1 = sin(q1);
% joint 2 (revolute)
q2 = q(2);
C2 = cos(q2);
S2 = sin(q2);
% joint 3 (tranlational)
q3 = q(3);

%% Compute Transformations
% Base to link 0
% rotation is composed of pi/2 around x axis and s0 around z'
% Rb0 = [1 0 0; 0 Ca0 -Sa0; 0 Sa0 Ca0] * [Cs0 -Ss0 0; Ss0 Cs0 0; 0 0 1];
% pb0 = [0.3; 0; 0]; % 300mm
% Tb0= [Rb0 pb0; 0 0 0 1];
    
% joint 1 (revolute)
R01= [C1 -S1 0;S1 C1 0; 0 0 1];
p01= pT';
T01= [R01 p01; 0 0 0 1];
% base to joint 1
% Tb1 = Tb0 * T01;
Tb1 = T01;
    
% joint 2 (revolute)
R12= [C2 -S2 0; Cs1*S2 Cs1*C2 Ss1; -Ss1*S2 -Ss1*C2 Cs1];
p12= [0; 0; 0];
T12= [R12 p12; 0 0 0 1];
Tb2= Tb1 * T12;

% joint 3 (tranlational)
R23= [1 0 0; 0 Cs2 Ss2; 0 -Ss2 Cs2];
p23= [0; q3*Ss2; q3*Cs2];
T23= [R23 p23; 0 0 0 1];
Tb3= Tb2 * T23;

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
    'Color',[0.6 0.6 0.6],'LineStyle','-','LineWidth',5);

end


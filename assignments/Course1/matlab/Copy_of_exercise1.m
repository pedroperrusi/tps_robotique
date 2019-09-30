%% On veut representer the robot link 1 as a circular arc
arc_length=2*pi/3;
radius=0.5;
n=100;
direction=1;
angle=0;
for i = 1 : n+1
    xc(:,i) = radius*cos(angle);
    yc(:,i) = radius*sin(angle);
    zc(:,i) = 0;
    angle = angle + direction * (arc_length)/n;
end

% for i = 1 : n+1
%     xc(:,i) = 0;
%     yc(:,i) = radius*cos(angle);
%     zc(:,i) = radius*sin(angle);
%     angle = angle + direction * (arc_length)/n;
% end

% Define a rotation homogeneous transform:
% R(y, -pi/2)
angle_r = -pi/2;
T = [cos(angle_r) -sin(angle_r) 0 0; 0 1 0 0; 0 sin(angle_r) cos(angle_r) 1];
P = [xc; yc; zc; ones(length(xc))]

P2 = P * T;

xc


plot3(xc,yc,zc,'b-'); grid on;
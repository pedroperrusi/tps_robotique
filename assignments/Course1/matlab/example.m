close all
arc_length=2*pi/3; % angular range for the arc (rad)
radius=0.5; % radius of the arc (m)
n=100; % number of points to be sampled
direction=1; % ?
angle=0; % initial angle
for i = 1 : n+1
    xc(:,i) = radius*cos(angle);
    yc(:,i) = radius*sin(angle);
    zc(:,i) = 0;
    angle = angle + direction * (arc_length)/n;
end
plot3(xc,yc,zc,'b.', 'MarkerSize',10); grid on; hold on;
xlabel('X'); ylabel('Y'); zlabel('Z');
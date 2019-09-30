example  % appelle l'esxampple
%% On veut representer the robot link 1 as a circular arc
arc_length=2*pi/3;
radius=0.5;
n=100;
direction=-1;
angle= pi - arc_length;

for i = 1 : n+1
    xc(:,i) = 0;
    yc(:,i) = -radius*sin(angle);
    zc(:,i) = radius*cos(angle);
    angle = angle + direction * (arc_length)/n;
end

plot3(xc,yc,zc,'r.', 'MarkerSize',10); grid on; hold on;
xlabel('X'); ylabel('Y'); zlabel('Z');

% problem parameters
arc_length=2*pi/3;
radius_robot=0.3;
radius_head=0.12;
n_points=100;

% Head centre position wrt to Fb reference system (vector)
xT= 0;
yT= 0;
zT= 0;
pT= [xT; yT; zT];

% angle between the first joint axis and xb
theta_b = 0.0;

% For joint position from 0 to pi/2
for q1=0:pi/20:pi/2;
     
%     % rotation q1
%     R01= % rotation matrix
%     p01= % translation 
%     T01= % transformation matrix
%     
%     % Trasnformation b->0
%     
%     Rb0= % rotation matrix
%     pb0= % translation in the head centre
%     Tb0= % transformation matrix
    
    T = eye(4);

    circular_arc(pT,radius_robot,arc_length,T,n_points)
    %hold on    
    
end


rotate3d on

hold on

colormap([1, 0.75, 0.79])
[xs,ys,zs]=sphere;

surf(xT+rh*xs,rh*ys,zT+rh*zs)

alpha(0.9)
shading interp


axis([0 xT+1.5*rr,yT-1.5*rr,yT+1.5*rr,0,zT+2*rr])
xlabel('x');ylabel('y');zlabel('z')

line([0,xT],[0 yT],[0,zT],'LineWidth',2,'LineStyle','--','Color','k')


C=cos(q);S=sin(q);

% joint 1
R01=[C(1),-S(1),0;S(1),C(1),0;0,0,1];  % rotation matrix
p01=[0;0;0]; % translation 
T01=[R01,p01;0,0,0,1]; % transformation matrix    
Tb1=Tb0*T01; 
    
% joint 2
R12=[C(2),-S(2),0;Cs(1)*S(2),Cs(1)*C(2),Ss(1);-Ss(1)*S(2),-Ss(1)*C(2),Cs(1)];  % rotation matrix
p12=[0;0;0]; % translation 
T12=[R12,p12;0,0,0,1]; % transformation matrix    
Tb2=Tb1*T12; 

% joint 3
R23=[1,0,0;0,Cs(2),Ss(2);0,-Ss(2),Cs(2)];  % rotation matrix
p23=[0;q(3)*Ss(2);q(3)*Cs(2)]; % translation 
T23=[R23,p23;0,0,0,1]; % transformation matrix    
Tb3=Tb2*T23;


plot3(xT,yT,zT,'bo','MarkerSize',5, 'MarkerFaceColor','r')
plot3(xT-rr*Tb2(1,3),yT-rr*Tb2(2,3),zT-rr*Tb2(3,3),'co','MarkerSize',12, 'MarkerFaceColor','k')
plot3(xT-rr*Tb3(1,3),yT-rr*Tb3(2,3),zT-rr*Tb3(3,3),'co','MarkerSize',12, 'MarkerFaceColor','k') 
plot3(xT-rr*Tb3(1,3),yT-rr*Tb3(2,3),zT-rr*Tb3(3,3),'bo','MarkerSize',15)

circular_arc(pT,rr,0,s(1),Tb1,'r-')
circular_arc(pT,rr,0,s(2),Tb2,'y-')
line([xT+(q(3)-rh-0.18)*Tb3(1,3) xT+(q(3)-rh)*Tb3(1,3)], ...
    [yT+(q(3)-rh-0.18)*Tb3(2,3) yT+(q(3)-rh)*Tb3(2,3)], ...
    [zT+(q(3)-rh-0.18)*Tb3(3,3) zT+(q(3)-rh)*Tb3(3,3)],...
    'Color',[0.6 0.6 0.6],'LineStyle','-','LineWidth',5)


% zoom to check (at the resolution)
%   axis([xT+(q(3)-rh)*Tb3(1,3)-0.005, xT+(q(3)-rh)*Tb3(1,3)+0.005,...
%       yT+(q(3)-rh)*Tb3(2,3)-0.005 yT+(q(3)-rh)*Tb3(2,3)+0.005,...
%       zT+(q(3)-rh)*Tb3(3,3)-0.005 zT+(q(3)-rh)*Tb3(3,3)+0.005])


rotate3d on
box on
grid on
view([0,-1,0]);
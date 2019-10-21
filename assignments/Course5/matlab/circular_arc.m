function circular_arc(pT,radius,angle_start,arc_length,T,plot_type)

angle=angle_start;n=100;
for i = 1 : n+1
    xc(:,i) = 0;
    yc(:,i) = radius*sin(pi+angle);
    zc(:,i) = radius*cos(pi+angle);
    Mt(:,i)=T*[xc(i);yc(i);zc(i);1];
    angle=angle+(arc_length)/n;
end

plot3(Mt(1,:),Mt(2,:),Mt(3,:),plot_type,'LineWidth',5)
plot3(Mt(1,1),Mt(2,1),Mt(3,1),'bo','MarkerSize',15)
line([pT(1),Mt(1,1)],[pT(2),Mt(2,1)],[pT(3),Mt(3,1)],'Color','k','LineStyle','--','LineWidth',0.2)
line([pT(1),Mt(1,n+1)],[pT(2),Mt(2,n+1)],[pT(3),Mt(3,n+1)],'Color','k','LineStyle','--','LineWidth',0.2)

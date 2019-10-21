%%%%%%%%%%%%%% FKM [rot,pos]=fkm(conf) %%%%%%%%%%%%%%%%

function [rot,pos]=fkm(conf)%%%%%%%%%%%%%% INIT %%%%%%%%%%%%%%

global Ss; global Cs;
global rh;

C=cos(conf);S=sin(conf);

D1=-S(2)*Ss(2);
D2=conf(3)*D1;
D3=Cs(1)*S(2);
D4=Cs(1)*C(2)*Ss(2)+Ss(1)*Cs(2);
D5=conf(3)*D4;
D6=-Ss(1)*S(2);
D7=-Ss(2)*Ss(1)*C(2)+Cs(1)*Cs(2);
D8=conf(3)*D7;
D9=C(1)*C(2)-S(1)*D3;
D10=C(1)*D1-S(1)*D4;
D11=C(1)*D2-S(1)*D5;
D12=S(1)*C(2)+C(1)*D3;
D13=S(1)*D1+C(1)*D4;
D14=S(1)*D2+C(1)*D5;

% R03
rot=[D9,D13*D6-D12*D7,D10;D12,D7*D9-D10*D6,D13;D6,D10*D12-D9*D13,D7];

% O4 position
pos(1)=D11-rh*D10; %x=px+r4*zx;
pos(2)=D14-rh*D13; %y=py+r4*zy;
pos(3)=D8-rh*D7;  %z=pz+r4*zz;


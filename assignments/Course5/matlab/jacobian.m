function [ J, Jg ] = jacobian( conf )
%JACOBIAN Computes the jacobian for a given joint configuration
global Ss; global Cs;
global rh;

% process joint configuration
C=cos(conf);S=sin(conf);

% Recover some parameters from FKM
D1=-S(2)*Ss(2);
D2=conf(3)*D1;
D4=Cs(1)*C(2)*Ss(2)+Ss(1)*Cs(2);
D5=conf(3)*D4;
D7=-Ss(2)*Ss(1)*C(2)+Cs(1)*Cs(2);
D10=C(1)*D1-S(1)*D4;
D13=S(1)*D1+C(1)*D4;

% Jacobian parameters
E1 = -D5*C(1) - D2*S(1);
E2 = (-conf(3)*Ss(2)) * (C(1)*C(2) - S(1)*S(2)*Cs(1));
E3 = -D5*S(1) + D2*C(1);
E4 = (-conf(3)*Ss(2)) * (S(1)*C(2) + C(1)*S(2)*Cs(1));
E5 = S(2)*Ss(1)*conf(3)*Ss(2);
E6 = -S(1)*Ss(1);
E7 = C(1)*Ss(1);

% Build Jacobian
Jg = [E1 E2 D10; ...
      E3 E4 D13; ...
      0  E5 D7;  ...
      0  E6 0;   ...
      0  E7 0;   ...
      1 Cs(1) 0];

% pass to the origin frame
D = [0      -rh*D7       rh*D13;...
     rh*D7      0       -rh*D10;...
     -rh*D13  rh*D10        0];
 
% C = eye(3);
% C = zeros(3,3);
 
J = [eye(3) D] * Jg;
  
end


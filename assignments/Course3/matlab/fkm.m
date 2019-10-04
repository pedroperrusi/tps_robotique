function [ effector_position ] = fkm( q )
%FKM Map the joints positions q to a 3D cartesian pose
%   q: 3x1 vector of joint angles or translations
%   effector_position: 3x1 vector of cartesian position of the end effector

% load tms constants from scripts
tms_constants

%% Process Joint State Insformation
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

%% Auxiliary variables to the computation
% between frames 1 and 3
D0 = C2;
D1 = -S2 * Ss2;
D2 = -q3 * D1;
D3 = Cs1 * S2;
D4 = C2 * Cs1 * Ss2 + Ss1 * Cs2;
D5 = q3 * D4;
D6 = -Ss1 * S2;
D7 = Cs1 * Cs2 - Ss1 * Ss2 * C2;
D8 = q3 * D7;
% between frames 0 and 3
D9 = C1 * C2 - S1 * D3;
D10 = C1 * D1 - S1 * D4;
D11 = C1 * D2 - S1 * D5;
D12 = S1 * C2 + C1 * D3;
D13 = S1 * D1 + C1 * D4;
D14 = S1 * D2 + C1 * D5;

%% end effector position
x = D11 - rh * D10;
y = D14 - rh * D13;
z = D8 - rh * D7;

effector_position = [x; y; z];

end


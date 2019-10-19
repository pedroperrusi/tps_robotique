function [ q ] = ikm( target_position )
%IKM Maps a ttarget cartesian position into possible joint states for the
%robot
% target_position: 3x1 vector of x y and z coordinates of the target
% position
% q: 3xN vector, where N is the number of solutions found

% load tms robot constants from script
tms_constants
% split cartesian information
x = target_position(1);
y = target_position(2);
z = target_position(3);

% auxiliar variables
% this computation may result in a positive or negative solution
sqrt_sum_pos = sqrt(x*x + y*y + z*z);
% eps_sum_pos = [1 -1]; % two possible solutions
x_over_sqrt_sum_pos = x / sqrt_sum_pos;
y_over_sqrt_sum_pos = y / sqrt_sum_pos;
z_over_sqrt_sum_pos = z / sqrt_sum_pos;
prod_cs1_cs2 = Cs1 * Cs2;
prod_ss1_ss2 = Ss1 * Ss2;

% iterate on possible solutions for q3, C2, S2, C1, S1
aux_solutions = zeros(4, 5);
q = zeros(2, 3);
i = 1;
j = i;
eps = -1;
% solve for joint 3
q3 = eps * sqrt_sum_pos + rh;
% solve for joint 2
C2 = (prod_cs1_cs2 - eps * z_over_sqrt_sum_pos)/prod_ss1_ss2;
% two possibilities for its sinus
eps_sin2 = [1 -1];
for eps2 = eps_sin2
    S2 = eps2 * sqrt(1 - C2*C2);
    % auxiliary variables
    D1 = -S2 * Ss2;
    D4 = C2*Cs1*Ss2 + Ss1*Cs2;
    % solve for joint 1
    C1 = (-x_over_sqrt_sum_pos*D1 + y_over_sqrt_sum_pos*D4) ...
            / (D1*D1 + D4*D4);
    S1 = (x_over_sqrt_sum_pos*D4 - y_over_sqrt_sum_pos*D1) ...
            / (D1*D1 + D4*D4);
    aux_solutions(i, :) = [C1 S1 C2 S2 q3];
    q(i, :) = [atan2(S1,C1) atan2(S2,C2) q3];
    i = i + 1;
end

% disp(aux_solutions)

end


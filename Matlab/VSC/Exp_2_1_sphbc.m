function dy = Exp_2_1sphbc( t, y, L, m, V_DC, V_s, R )
%sphbc Summary of this function goes here
%   Detailed explanation goes here

V_t = m * V_DC / 2;
dy = (V_t - V_s - R * y) / L;

end


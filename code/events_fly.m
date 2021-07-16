function [value,isterminal,direction]=events_fly(t,X)
global L
x = X(1);
y = X(2);
theta1 = X(3);
theta2 = X(4);

r_P=[x;y];
r_Q=[x+2*L*cos(theta1);y+2*L*sin(theta1)];
r_R =r_Q+[2*L*cos(theta1+theta2);2*L*sin(theta1+theta2)];

stop_fly = r_P(2) + 1e-3;

stop_simu = 1; % detect wrong landing points
if  r_R(2) <= 0 || r_Q(2) <= 0
    stop_simu = 0;
end


angle_constraint=1;
v_1 = [r_R.' 0] - [r_P.' 0];
v_2 = [0,1,0];
angle = atan2(norm(cross(v_1, v_2)), dot(v_1, v_2));
if   angle > deg2rad(60)
    angle_constraint =0;
end

value = [stop_fly,stop_simu,angle_constraint];
isterminal = [1,1,1];
direction = [];
end
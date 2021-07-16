function [value,isterminal,direction]=events_fly(t,X)
global L
x = X(1);
y = X(2);
theta1 = X(3);
theta2 = X(4);

r_P=[x;y];
r_Q=[x+2*L*cos(theta1);y+2*L*sin(theta1)];
r_R =r_Q+[2*L*cos(theta1+theta2);2*L*sin(theta1+theta2)];

v_1 = [r_R.' 0] - [r_P.' 0];
v_2 = [0,1,0];
angle_constraint = atan2(norm(cross(v_1, v_2)), dot(v_1, v_2)) - deg2rad(60);

value = [r_P(2),r_R(2),r_Q(2),angle_constraint];
isterminal = ones(1,length(value));
direction = [-1,-1,-1,0];
end
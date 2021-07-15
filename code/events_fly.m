function [value,isterminal,direction]=events_fly(t,X)
global L
x = X(1);
y = X(2);
theta1 = X(3);
theta2 = X(4);

r_P=[x;y];
r_Q=[x+2*L*cos(theta1);y+2*L*sin(theta1)];
r_R = r_Q + [2*L*cos(theta1+theta2);2*L*sin(theta1+theta2)];

stop_fly = 1;
if r_P(2) <= 1e-9
    stop_fly = 0;
end
stop_simu = 1; % detect wrong landing points
if  r_R(2) <= 1e-12 || r_Q(2) <= 1e-12
    stop_simu = 0;
end

xd = r_P(1)-r_R(1);
yd = r_P(2)-r_R(2);
angle_constraint = abs(pi/2 - atan2(yd,xd)) - deg2rad(60);

value = [stop_fly,stop_simu,angle_constraint];
isterminal = [1,1,1];
direction = [];
end
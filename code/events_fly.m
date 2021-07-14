function [value,isterminal,direction]=events_fly(t,X)
global m g L
L=0.15;
x = X(1);
y = X(2);
theta1 = X(3);
theta2 = X(4);

xd = X(5);
yd = X(6);
theta1d = X(7);
theta2d = X(8);

r_P=[x;y];
r_Q=[x+2*L*cos(theta1);y+2*L*sin(theta1)];
r_R = r_Q + [2*l*cos(theta1+theta2),2*l*sin(theta1+theta2)];

stop_fly = 1;
if r_P(2) <= 0
    stop_fly = 0;
end

stop_simu = 1; % detect wrong landing points
if  r_R(2) <= 0 || r_Q(2) <= 0
    stop_simu = 0;
end

value = [stop_fly,stop_simu];
isterminal = [1,1];
direction = [-1,-1];
end
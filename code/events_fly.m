function [value,isterminal,direction]=events_fly(t,X)

l=0.15;
x = X(1);
y = X(2);
theta_1 = X(3);
theta_2 = X(4);

xd = X(5);
yd = X(6);
theta_1d = X(7);
theta_2d = X(8);

r_P=[x-2*l*cos(theta_1),y-2*l*sin(theta_1)].';
r_Q=[x;y];
r_R = [x+2*l*cos(theta_1+theta_2),y+2*l*sin(theta_1+theta_2)].';

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
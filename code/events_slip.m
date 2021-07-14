function [value,isterminal,direction]=events_slip(t,X)

global sgn_slip
m=0.3;
g=10;
l=0.15;
mu = 0.3;

x = X(1);
y = X(2);
theta_1 = X(3);
theta_2 = X(4);

xd = X(5);
yd = X(6);
theta_1d = X(7);
theta_2d = X(8);
vt =  xd + 2*l*theta_1d*sin(theta_1);
sgn_slip = sign(vt);
tau=tau_calc(t,X);

theta_1dd = (42*l^2*m*theta_1d^2*sin(theta_2) - 9*tau*cos(2*theta_1 + 2*theta_2) - 45*tau*cos(theta_2) - 27*tau*cos(2*theta_1 + theta_2) - 9*mu*sgn_slip*tau*sin(2*theta_1 + 2*theta_2) - 39*tau + 42*l^2*m*theta_2d^2*sin(theta_2) - 81*g*l*m*cos(theta_1) + 18*l^2*m*theta_1d^2*sin(2*theta_1 + theta_2) + 18*l^2*m*theta_2d^2*sin(2*theta_1 + theta_2) + 27*mu*sgn_slip*tau*sin(theta_2) + 9*g*l*m*cos(theta_1 + 2*theta_2) + 54*l^2*m*theta_1d^2*sin(2*theta_1) + 18*l^2*m*theta_1d^2*sin(2*theta_2) - 27*mu*sgn_slip*tau*sin(2*theta_1 + theta_2) + 54*l^2*m*mu*sgn_slip*theta_1d^2 + 84*l^2*m*theta_1d*theta_2d*sin(theta_2) + 36*l^2*m*theta_1d*theta_2d*sin(2*theta_1 + theta_2) + 18*l^2*m*mu*sgn_slip*theta_1d^2*cos(theta_2) + 18*l^2*m*mu*sgn_slip*theta_2d^2*cos(theta_2) - 18*l^2*m*mu*sgn_slip*theta_1d^2*cos(2*theta_1 + theta_2) - 18*l^2*m*mu*sgn_slip*theta_2d^2*cos(2*theta_1 + theta_2) - 81*g*l*m*mu*sgn_slip*sin(theta_1) - 54*l^2*m*mu*sgn_slip*theta_1d^2*cos(2*theta_1) + 9*g*l*m*mu*sgn_slip*sin(theta_1 + 2*theta_2) + 36*l^2*m*mu*sgn_slip*theta_1d*theta_2d*cos(theta_2) - 36*l^2*m*mu*sgn_slip*theta_1d*theta_2d*cos(2*theta_1 + theta_2))/(2*l^2*m*(27*cos(2*theta_1) - 9*cos(2*theta_2) - 3*cos(2*theta_1 + 2*theta_2) + 27*mu*sgn_slip*sin(2*theta_1) - 3*mu*sgn_slip*sin(2*theta_1 + 2*theta_2) + 41));
theta_2dd = -(3*g*l*m*cos(theta_1 + theta_2) - 81*tau*cos(2*theta_1) - 9*tau*cos(2*theta_1 + 2*theta_2) - 90*tau*cos(theta_2) - 54*tau*cos(2*theta_1 + theta_2) - 9*mu*sgn_slip*tau*sin(2*theta_1 + 2*theta_2) - 150*tau + 120*l^2*m*theta_1d^2*sin(theta_2) + 42*l^2*m*theta_2d^2*sin(theta_2) - 81*g*l*m*cos(theta_1) + 36*l^2*m*theta_1d^2*sin(2*theta_1 + theta_2) + 18*l^2*m*theta_2d^2*sin(2*theta_1 + theta_2) - 27*g*l*m*cos(theta_1 - theta_2) + 9*g*l*m*cos(theta_1 + 2*theta_2) + 54*l^2*m*theta_1d^2*sin(2*theta_1) + 36*l^2*m*theta_1d^2*sin(2*theta_2) + 18*l^2*m*theta_2d^2*sin(2*theta_2) - 54*mu*sgn_slip*tau*sin(2*theta_1 + theta_2) + 6*l^2*m*theta_1d^2*sin(2*theta_1 + 2*theta_2) + 6*l^2*m*theta_2d^2*sin(2*theta_1 + 2*theta_2) - 81*mu*sgn_slip*tau*sin(2*theta_1) + 60*l^2*m*mu*sgn_slip*theta_1d^2 + 6*l^2*m*mu*sgn_slip*theta_2d^2 + 84*l^2*m*theta_1d*theta_2d*sin(theta_2) + 36*l^2*m*theta_1d*theta_2d*sin(2*theta_1 + theta_2) + 36*l^2*m*theta_1d*theta_2d*sin(2*theta_2) + 12*l^2*m*theta_1d*theta_2d*sin(2*theta_1 + 2*theta_2) + 36*l^2*m*mu*sgn_slip*theta_1d^2*cos(theta_2) + 18*l^2*m*mu*sgn_slip*theta_2d^2*cos(theta_2) + 3*g*l*m*mu*sgn_slip*sin(theta_1 + theta_2) - 36*l^2*m*mu*sgn_slip*theta_1d^2*cos(2*theta_1 + theta_2) - 18*l^2*m*mu*sgn_slip*theta_2d^2*cos(2*theta_1 + theta_2) + 12*l^2*m*mu*sgn_slip*theta_1d*theta_2d - 81*g*l*m*mu*sgn_slip*sin(theta_1) - 54*l^2*m*mu*sgn_slip*theta_1d^2*cos(2*theta_1) - 27*g*l*m*mu*sgn_slip*sin(theta_1 - theta_2) + 9*g*l*m*mu*sgn_slip*sin(theta_1 + 2*theta_2) - 6*l^2*m*mu*sgn_slip*theta_1d^2*cos(2*theta_1 + 2*theta_2) - 6*l^2*m*mu*sgn_slip*theta_2d^2*cos(2*theta_1 + 2*theta_2) + 36*l^2*m*mu*sgn_slip*theta_1d*theta_2d*cos(theta_2) - 36*l^2*m*mu*sgn_slip*theta_1d*theta_2d*cos(2*theta_1 + theta_2) - 12*l^2*m*mu*sgn_slip*theta_1d*theta_2d*cos(2*theta_1 + 2*theta_2))/(2*l^2*m*(27*cos(2*theta_1) - 9*cos(2*theta_2) - 3*cos(2*theta_1 + 2*theta_2) + 27*mu*sgn_slip*sin(2*theta_1) - 3*mu*sgn_slip*sin(2*theta_1 + 2*theta_2) + 41));



[~,lambda_t_general,lambda_n_slip,lambda_ndot] = lam_calc(X,tau,theta_1dd,theta_2dd);

lambda_t = lambda_t_general;
lambda_n = lambda_n_slip;

r_Q=[x;y];
r_R = [x+2*l*cos(theta_1+theta_2),y+2*l*sin(theta_1+theta_2)].';

stop_slip=1;
seperation = 1;
if  abs(vt)<10^(-9) && abs(lambda_t) < abs(mu*lambda_n)
    stop_slip = 0;
end

if  lambda_n <= 0 && lambda_ndot < 0
    seperation = 0;
end

touch = 1; % to detect when terminate the jumping motion
if r_Q(2) <= 10^(-11) || r_R(2) <= 10^(-11)
    touch = 0;
end

value = [stop_slip,seperation,touch];
isterminal = [1,1,1];
direction = [0,-1,-1];
end
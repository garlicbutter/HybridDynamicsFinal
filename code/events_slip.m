function [value,isterminal,direction]=events_slip(t,X)

global sigma m g L mu
m=0.3;
g=10;
L=0.15;
mu = 0.3;

x = X(1);
y = X(2);
theta1 = X(3);
theta2 = X(4);
xd = X(5);
yd = X(6);
theta1d = X(7);
theta2d = X(8);

vt =  xd;
sigma = sign(vt);

tau=tau_calc(t);

[~,lam_t,lam_n_slip,lam_n_dot] = lam_calc(X,tau);

r_P=[x;y];
r_Q=[x+2*L*cos(theta1);y+2*L*sin(theta1)];
r_R = r_Q + [2*L*cos(theta1+theta2);2*L*sin(theta1+theta2)];

stop_slip=1;
if  abs(vt)<10^(-9) && abs(lam_t) < abs(mu*lam_n_slip)
    stop_slip = 0;
end

seperation = 1;
if  lam_n_slip <= 0 && lam_n_dot < 0
    seperation = 0;
end

ground_contact = 1;
if r_Q(2) <= 0 || r_R(2) <= 0
    ground_contact = 0;
end

value = [stop_slip,seperation,ground_contact];
isterminal = [1,1,1];
direction = [-1,-1,-1];
end
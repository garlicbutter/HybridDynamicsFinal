function  [value,isterminal,direction] = events_stick(t,X)
global m g L mu
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
theta1dd = 0;
theta2dd = 0;

tau=tau_calc(t,X);
[lambda_n_stick,lambda_t_general,~,~] = lam_calc(X,tau,theta1dd,theta2dd);

r_P=[x;y];
r_Q=[x+2*L*cos(theta1);y+2*L*sin(theta1)];
r_R = r_Q + [2*l*cos(theta1+theta2),2*l*sin(theta1+theta2)];

stop_positive = mu*lambda_n_stick - lambda_t_general;
stop_negative = -mu*lambda_n_stick - lambda_t_general;

touch_ground = 1; 
if r_Q(2) <= 0 || r_R(2) <= 0
    touch_ground = 0;
end

value = [stop_positive,stop_negative,touch_ground];
isterminal = [1,1,1];
direction = [-1,1,-1];

end
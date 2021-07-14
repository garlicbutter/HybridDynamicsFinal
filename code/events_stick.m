function  [value,isterminal,direction] = events_stick(t,X)

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
tau=tau_calc(t,X);

theta_1dd = 0; % No need of this value
theta_2dd = 0; % No need of this value
[lambda_n_stick,lambda_t_general,~,~] = lam_calc(X,tau,theta_1dd,theta_2dd);

lambda_t = lambda_t_general;
lambda_n = lambda_n_stick;
lambda_t/lambda_n;

r_P=[x-2*l*cos(theta_1),y-2*l*sin(theta_1)].';
r_Q=[x;y];
r_R = [x+2*l*cos(theta_1+theta_2),y+2*l*sin(theta_1+theta_2)].';

stop_pos = mu*lambda_n - lambda_t;
stop_neg = -mu*lambda_n - lambda_t;

touch = 1; % to detect when terminate the jumping motion
if r_Q(2) <= 0 || r_R(2) <= 0
    touch = 0;
end

value = [stop_pos,stop_neg,touch];
isterminal = [1,1,1];
direction = [-1,1,-1];
end
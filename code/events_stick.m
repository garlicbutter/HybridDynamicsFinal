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

tau=tau_calc(t);
[lam_n,lam_t,~,~] = lam_calc(X,tau);

r_P =[x;y];
r_Q=[x+2*L*cos(theta1); y+2*L*sin(theta1)];
r_R = r_Q + [2*L*cos(theta1+theta2);2*L*sin(theta1+theta2)];

stop_positive = mu*lam_n - lam_t;
stop_negative = -mu*lam_n - lam_t;

ground_contact = 1;
if r_Q(2) <= 0 || r_R(2) <= 0
    ground_contact = 0;
end

value = [ground_contact,stop_positive,stop_negative];
isterminal = [1,1,1];
direction = [];

end
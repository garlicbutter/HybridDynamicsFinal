function dXdt=sys_fly(t,X)
global ti
tau=calc_tau(t,X,2);

m=0.3;
g=10;
l=0.15;
dXdt = zeros(8,1);

x = X(1);
y = X(2);
theta_1 = X(3);
theta_2 = X(4);

dXdt(1) = X(5); x_d = X(5);
dXdt(2) = X(6); y_d = X(6);
dXdt(3) = X(7); theta_1d = X(7);
dXdt(4) = X(8); theta_2d= X(8);

dXdt(5) = -(39*tau*sin(theta_1 + theta_2) + 39*tau*sin(theta_1) + 9*tau*sin(theta_1 - theta_2) + 9*tau*sin(theta_1 + 2*theta_2) + 28*l^2*m*theta_1d^2*cos(theta_1 + theta_2) + 28*l^2*m*theta_2d^2*cos(theta_1 + theta_2) - 28*l^2*m*theta_1d^2*cos(theta_1) - 12*l^2*m*theta_1d^2*cos(theta_1 - theta_2) + 12*l^2*m*theta_1d^2*cos(theta_1 + 2*theta_2) - 12*l^2*m*theta_2d^2*cos(theta_1 - theta_2) + 56*l^2*m*theta_1d*theta_2d*cos(theta_1 + theta_2) - 24*l^2*m*theta_1d*theta_2d*cos(theta_1 - theta_2))/(l*m*(9*cos(2*theta_2) - 41));
dXdt(6) = (39*tau*cos(theta_1 + theta_2) + 39*tau*cos(theta_1) + 9*tau*cos(theta_1 - theta_2) + 9*tau*cos(theta_1 + 2*theta_2) + 41*g*l*m - 28*l^2*m*theta_1d^2*sin(theta_1 + theta_2) - 28*l^2*m*theta_2d^2*sin(theta_1 + theta_2) + 28*l^2*m*theta_1d^2*sin(theta_1) + 12*l^2*m*theta_1d^2*sin(theta_1 - theta_2) - 12*l^2*m*theta_1d^2*sin(theta_1 + 2*theta_2) + 12*l^2*m*theta_2d^2*sin(theta_1 - theta_2) - 9*g*l*m*cos(2*theta_2) - 56*l^2*m*theta_1d*theta_2d*sin(theta_1 + theta_2) + 24*l^2*m*theta_1d*theta_2d*sin(theta_1 - theta_2))/(l*m*(9*cos(2*theta_2) - 41));
dXdt(7) =  -(15*l^2*m*theta_1d^2*sin(theta_2) - 18*tau*cos(theta_2) - 30*tau + 15*l^2*m*theta_2d^2*sin(theta_2) + 9*l^2*m*theta_1d^2*cos(theta_2)*sin(theta_2) + 30*l^2*m*theta_1d*theta_2d*sin(theta_2))/(l^2*m*(9*cos(theta_2)^2 - 25));
dXdt(8) = (6*m*sin(theta_2)*l^2*theta_1d^2 + 6*m*sin(theta_2)*l^2*theta_1d*theta_2d + 3*m*sin(theta_2)*l^2*theta_2d^2 - 12*tau)/(l^2*m*(3*cos(theta_2) - 5));
end
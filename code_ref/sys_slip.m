function dXdt=sys_slip(t,X,sigma)
m=0.3;
g=10;
l=0.15;
mu=0.3;
tau=calc_tau(t,X,1);
dXdt=zeros(8,1);

x=X(1);y=X(2);theta1=X(3);theta2=X(4);
xd=X(5);yd=X(6);theta1d=X(7);theta2d=X(8);

dXdt(1)=X(5);
dXdt(2)=X(6);
dXdt(3)=X(7);
dXdt(4)=X(8);
dXdt(5)=(9*tau*sin(3*theta1 + 2*theta2) + 60*tau*sin(theta1 + theta2) + 24*tau*sin(theta1) - 9*tau*sin(theta1 - theta2) + 9*tau*sin(theta1 + 2*theta2) + 27*tau*sin(3*theta1 + theta2) + 44*l^2*m*theta1d^2*cos(theta1 + theta2) + 44*l^2*m*theta2d^2*cos(theta1 + theta2) - 3*g*l*m*sin(2*theta1 + 2*theta2) - 9*mu*sigma*tau*cos(3*theta1 + 2*theta2) - 92*l^2*m*theta1d^2*cos(theta1) + 12*mu*sigma*tau*cos(theta1 + theta2) - 6*l^2*m*theta1d^2*cos(theta1 - theta2) + 30*l^2*m*theta1d^2*cos(theta1 + 2*theta2) - 6*l^2*m*theta2d^2*cos(theta1 - theta2) + 18*l^2*m*theta1d^2*cos(3*theta1 + theta2) + 18*l^2*m*theta2d^2*cos(3*theta1 + theta2) + 54*mu*sigma*tau*cos(theta1) + 27*mu*sigma*tau*cos(theta1 - theta2) - 9*mu*sigma*tau*cos(theta1 + 2*theta2) - 27*mu*sigma*tau*cos(3*theta1 + theta2) + 6*l^2*m*theta1d^2*cos(3*theta1 + 2*theta2) + 27*g*l*m*sin(2*theta1) + 9*g*l*m*sin(2*theta2) + 88*l^2*m*theta1d*theta2d*cos(theta1 + theta2) - g*l*m*mu*sigma - 12*l^2*m*theta1d*theta2d*cos(theta1 - theta2) + 36*l^2*m*theta1d*theta2d*cos(3*theta1 + theta2) - 16*l^2*m*mu*sigma*theta1d^2*sin(theta1 + theta2) - 16*l^2*m*mu*sigma*theta2d^2*sin(theta1 + theta2) - 36*l^2*m*mu*sigma*theta1d^2*sin(theta1) + 18*l^2*m*mu*sigma*theta1d^2*sin(theta1 - theta2) - 6*l^2*m*mu*sigma*theta1d^2*sin(theta1 + 2*theta2) + 18*l^2*m*mu*sigma*theta2d^2*sin(theta1 - theta2) + 18*l^2*m*mu*sigma*theta1d^2*sin(3*theta1 + theta2) + 18*l^2*m*mu*sigma*theta2d^2*sin(3*theta1 + theta2) - 27*g*l*m*mu*sigma*cos(2*theta1) + 9*g*l*m*mu*sigma*cos(2*theta2) + 6*l^2*m*mu*sigma*theta1d^2*sin(3*theta1 + 2*theta2) + 3*g*l*m*mu*sigma*cos(2*theta1 + 2*theta2) - 32*l^2*m*mu*sigma*theta1d*theta2d*sin(theta1 + theta2) + 36*l^2*m*mu*sigma*theta1d*theta2d*sin(theta1 - theta2) + 36*l^2*m*mu*sigma*theta1d*theta2d*sin(3*theta1 + theta2))/(2*l*m*(27*cos(2*theta1) - 9*cos(2*theta2) - 3*cos(2*theta1 + 2*theta2) + 27*mu*sigma*sin(2*theta1) - 3*mu*sigma*sin(2*theta1 + 2*theta2) + 41));
dXdt(6)=-(9*tau*cos(3*theta1 + 2*theta2) + 72*tau*cos(theta1 + theta2) + 78*tau*cos(theta1) + 45*tau*cos(theta1 - theta2) + 9*tau*cos(theta1 + 2*theta2) + 27*tau*cos(3*theta1 + theta2) + 81*g*l*m - 9*g*l*m*cos(2*theta1 + 2*theta2) - 60*l^2*m*theta1d^2*sin(theta1 + theta2) - 60*l^2*m*theta2d^2*sin(theta1 + theta2) + 9*mu*sigma*tau*sin(3*theta1 + 2*theta2) + 56*l^2*m*theta1d^2*sin(theta1) + 42*l^2*m*theta1d^2*sin(theta1 - theta2) - 30*l^2*m*theta1d^2*sin(theta1 + 2*theta2) + 42*l^2*m*theta2d^2*sin(theta1 - theta2) - 18*l^2*m*theta1d^2*sin(3*theta1 + theta2) - 18*l^2*m*theta2d^2*sin(3*theta1 + theta2) + 27*mu*sigma*tau*sin(theta1 - theta2) + 9*mu*sigma*tau*sin(theta1 + 2*theta2) + 27*mu*sigma*tau*sin(3*theta1 + theta2) + 81*g*l*m*cos(2*theta1) - 9*g*l*m*cos(2*theta2) - 6*l^2*m*theta1d^2*sin(3*theta1 + 2*theta2) - 120*l^2*m*theta1d*theta2d*sin(theta1 + theta2) + 84*l^2*m*theta1d*theta2d*sin(theta1 - theta2) - 36*l^2*m*theta1d*theta2d*sin(3*theta1 + theta2) - 18*l^2*m*mu*sigma*theta1d^2*cos(theta1 - theta2) - 6*l^2*m*mu*sigma*theta1d^2*cos(theta1 + 2*theta2) - 18*l^2*m*mu*sigma*theta2d^2*cos(theta1 - theta2) + 18*l^2*m*mu*sigma*theta1d^2*cos(3*theta1 + theta2) + 18*l^2*m*mu*sigma*theta2d^2*cos(3*theta1 + theta2) + 6*l^2*m*mu*sigma*theta1d^2*cos(3*theta1 + 2*theta2) + 81*g*l*m*mu*sigma*sin(2*theta1) - 9*g*l*m*mu*sigma*sin(2*theta2) - 9*g*l*m*mu*sigma*sin(2*theta1 + 2*theta2) - 36*l^2*m*mu*sigma*theta1d*theta2d*cos(theta1 - theta2) + 36*l^2*m*mu*sigma*theta1d*theta2d*cos(3*theta1 + theta2))/(2*l*m*(27*cos(2*theta1) - 9*cos(2*theta2) - 3*cos(2*theta1 + 2*theta2) + 27*mu*sigma*sin(2*theta1) - 3*mu*sigma*sin(2*theta1 + 2*theta2) + 41));
dXdt(7)=(42*l^2*m*theta1d^2*sin(theta2) - 9*tau*cos(2*theta1 + 2*theta2) - 45*tau*cos(theta2) - 27*tau*cos(2*theta1 + theta2) - 9*mu*sigma*tau*sin(2*theta1 + 2*theta2) - 39*tau + 42*l^2*m*theta2d^2*sin(theta2) - 81*g*l*m*cos(theta1) + 18*l^2*m*theta1d^2*sin(2*theta1 + theta2) + 18*l^2*m*theta2d^2*sin(2*theta1 + theta2) + 27*mu*sigma*tau*sin(theta2) + 9*g*l*m*cos(theta1 + 2*theta2) + 54*l^2*m*theta1d^2*sin(2*theta1) + 18*l^2*m*theta1d^2*sin(2*theta2) - 27*mu*sigma*tau*sin(2*theta1 + theta2) + 54*l^2*m*mu*sigma*theta1d^2 + 84*l^2*m*theta1d*theta2d*sin(theta2) + 36*l^2*m*theta1d*theta2d*sin(2*theta1 + theta2) + 18*l^2*m*mu*sigma*theta1d^2*cos(theta2) + 18*l^2*m*mu*sigma*theta2d^2*cos(theta2) - 18*l^2*m*mu*sigma*theta1d^2*cos(2*theta1 + theta2) - 18*l^2*m*mu*sigma*theta2d^2*cos(2*theta1 + theta2) - 81*g*l*m*mu*sigma*sin(theta1) - 54*l^2*m*mu*sigma*theta1d^2*cos(2*theta1) + 9*g*l*m*mu*sigma*sin(theta1 + 2*theta2) + 36*l^2*m*mu*sigma*theta1d*theta2d*cos(theta2) - 36*l^2*m*mu*sigma*theta1d*theta2d*cos(2*theta1 + theta2))/(2*l^2*m*(27*cos(2*theta1) - 9*cos(2*theta2) - 3*cos(2*theta1 + 2*theta2) + 27*mu*sigma*sin(2*theta1) - 3*mu*sigma*sin(2*theta1 + 2*theta2) + 41));
dXdt(8)=-(3*g*l*m*cos(theta1 + theta2) - 81*tau*cos(2*theta1) - 9*tau*cos(2*theta1 + 2*theta2) - 90*tau*cos(theta2) - 54*tau*cos(2*theta1 + theta2) - 9*mu*sigma*tau*sin(2*theta1 + 2*theta2) - 150*tau + 120*l^2*m*theta1d^2*sin(theta2) + 42*l^2*m*theta2d^2*sin(theta2) - 81*g*l*m*cos(theta1) + 36*l^2*m*theta1d^2*sin(2*theta1 + theta2) + 18*l^2*m*theta2d^2*sin(2*theta1 + theta2) - 27*g*l*m*cos(theta1 - theta2) + 9*g*l*m*cos(theta1 + 2*theta2) + 54*l^2*m*theta1d^2*sin(2*theta1) + 36*l^2*m*theta1d^2*sin(2*theta2) + 18*l^2*m*theta2d^2*sin(2*theta2) - 54*mu*sigma*tau*sin(2*theta1 + theta2) + 6*l^2*m*theta1d^2*sin(2*theta1 + 2*theta2) + 6*l^2*m*theta2d^2*sin(2*theta1 + 2*theta2) - 81*mu*sigma*tau*sin(2*theta1) + 60*l^2*m*mu*sigma*theta1d^2 + 6*l^2*m*mu*sigma*theta2d^2 + 84*l^2*m*theta1d*theta2d*sin(theta2) + 36*l^2*m*theta1d*theta2d*sin(2*theta1 + theta2) + 36*l^2*m*theta1d*theta2d*sin(2*theta2) + 12*l^2*m*theta1d*theta2d*sin(2*theta1 + 2*theta2) + 36*l^2*m*mu*sigma*theta1d^2*cos(theta2) + 18*l^2*m*mu*sigma*theta2d^2*cos(theta2) + 3*g*l*m*mu*sigma*sin(theta1 + theta2) - 36*l^2*m*mu*sigma*theta1d^2*cos(2*theta1 + theta2) - 18*l^2*m*mu*sigma*theta2d^2*cos(2*theta1 + theta2) + 12*l^2*m*mu*sigma*theta1d*theta2d - 81*g*l*m*mu*sigma*sin(theta1) - 54*l^2*m*mu*sigma*theta1d^2*cos(2*theta1) - 27*g*l*m*mu*sigma*sin(theta1 - theta2) + 9*g*l*m*mu*sigma*sin(theta1 + 2*theta2) - 6*l^2*m*mu*sigma*theta1d^2*cos(2*theta1 + 2*theta2) - 6*l^2*m*mu*sigma*theta2d^2*cos(2*theta1 + 2*theta2) + 36*l^2*m*mu*sigma*theta1d*theta2d*cos(theta2) - 36*l^2*m*mu*sigma*theta1d*theta2d*cos(2*theta1 + theta2) - 12*l^2*m*mu*sigma*theta1d*theta2d*cos(2*theta1 + 2*theta2))/(2*l^2*m*(27*cos(2*theta1) - 9*cos(2*theta2) - 3*cos(2*theta1 + 2*theta2) + 27*mu*sigma*sin(2*theta1) - 3*mu*sigma*sin(2*theta1 + 2*theta2) + 41));
end
function dXdt=sys_stick(t,X)
m=0.3;
g=10;
l=0.15;
dXdt=zeros(8,1);
tau=calc_tau(t,X,1);
x=X(1);y=X(2);theta1=X(3);theta2=X(4);
xd=X(5);yd=X(6);theta1d=X(7);theta2d=X(8);

dXdt(1)=X(5);
dXdt(2)=X(6);
dXdt(3)=X(7);
dXdt(4)=X(8);
dXdt(5)=(32*l^2*m*theta1d^2*cos(theta1) - 9*tau*cos(theta2)*sin(theta1) - 6*tau*sin(theta1) - 9*g*l*m*sin(2*theta1) - (9*g*l*m*sin(2*theta2))/2 + 12*l^2*m*theta1d^2*sin(theta1)*sin(theta2) + 12*l^2*m*theta2d^2*sin(theta1)*sin(theta2) - 18*l^2*m*theta1d^2*cos(theta1)*cos(theta2)^2 + 18*l^2*m*theta1d^2*cos(theta2)*sin(theta1)*sin(theta2) + 24*l^2*m*theta1d*theta2d*sin(theta1)*sin(theta2) + 9*g*l*m*cos(theta1)*cos(theta2)^2*sin(theta1) + 9*g*l*m*cos(theta1)^2*cos(theta2)*sin(theta2))/(l*m*(9*cos(theta2)^2 - 16));
dXdt(6)=-(9*g*l*m*cos(theta1)^2*cos(theta2)^2 - 9*tau*cos(theta1)*cos(theta2) - 32*l^2*m*theta1d^2*sin(theta1) - 18*g*l*m*cos(theta1)^2 - 6*tau*cos(theta1) + 12*l^2*m*theta1d^2*cos(theta1)*sin(theta2) + 12*l^2*m*theta2d^2*cos(theta1)*sin(theta2) + 18*l^2*m*theta1d^2*cos(theta2)^2*sin(theta1) + 18*l^2*m*theta1d^2*cos(theta1)*cos(theta2)*sin(theta2) + 24*l^2*m*theta1d*theta2d*cos(theta1)*sin(theta2) - 9*g*l*m*cos(theta1)*cos(theta2)*sin(theta1)*sin(theta2))/(l*m*(9*cos(theta2)^2 - 16));
dXdt(7)=-(24*l^2*m*theta1d^2*sin(theta2) - 18*tau*cos(theta2) - 12*tau + 24*l^2*m*theta2d^2*sin(theta2) - 27*g*l*m*cos(theta1) + 9*g*l*m*cos(theta1 + 2*theta2) + 18*l^2*m*theta1d^2*sin(2*theta2) + 48*l^2*m*theta1d*theta2d*sin(theta2))/(2*l^2*m*(9*cos(2*theta2) - 23));
dXdt(8)=(21*g*l*m*cos(theta1 + theta2) - 36*tau*cos(theta2) - 60*tau + 120*l^2*m*theta1d^2*sin(theta2) + 24*l^2*m*theta2d^2*sin(theta2) - 27*g*l*m*cos(theta1) - 27*g*l*m*cos(theta1 - theta2) + 9*g*l*m*cos(theta1 + 2*theta2) + 36*l^2*m*theta1d^2*sin(2*theta2) + 18*l^2*m*theta2d^2*sin(2*theta2) + 48*l^2*m*theta1d*theta2d*sin(theta2) + 36*l^2*m*theta1d*theta2d*sin(2*theta2))/(2*l^2*m*(9*cos(2*theta2) - 23));
end

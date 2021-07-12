function dXdt=sys_flying(t,X)

global ti
m=0.3;
g=10;
l=0.15;
dXdt=zeros(8,1);
tau=calc_tau(t,X,2);
x=X(1);y=X(2);theta1=X(3);theta2=X(4);
xd=X(5);yd=X(6);theta1d=X(7);theta2d=X(8);

dXdt(1)=X(5);
dXdt(2)=X(6);
dXdt(3)=X(7);
dXdt(4)=X(8);
dXdt(5)=-(27*theta1d^2*cos(theta1 + 2*theta2) - 27*theta1d^2*cos(theta1 - theta2) - 63*theta1d^2*cos(theta1) - 27*theta2d^2*cos(theta1 - theta2) + 13000*tau*sin(theta1 + theta2) + 13000*tau*sin(theta1) + 63*theta1d^2*cos(theta1 + theta2) + 63*theta2d^2*cos(theta1 + theta2) + 3000*tau*sin(theta1 - theta2) + 3000*tau*sin(theta1 + 2*theta2) - 54*theta1d*theta2d*cos(theta1 - theta2) + 126*theta1d*theta2d*cos(theta1 + theta2))/(135*cos(2*theta2) - 615);
dXdt(6)=(63*theta1d^2*sin(theta1) - 1350*cos(2*theta2) + 27*theta1d^2*sin(theta1 - theta2) - 27*theta1d^2*sin(theta1 + 2*theta2) + 27*theta2d^2*sin(theta1 - theta2) + 13000*tau*cos(theta1 + theta2) + 13000*tau*cos(theta1) + 3000*tau*cos(theta1 - theta2) + 3000*tau*cos(theta1 + 2*theta2) - 63*theta1d^2*sin(theta1 + theta2) - 63*theta2d^2*sin(theta1 + theta2) - 126*theta1d*theta2d*sin(theta1 + theta2) + 54*theta1d*theta2d*sin(theta1 - theta2) + 6150)/(135*cos(2*theta2) - 615);
dXdt(7)=-(135*theta1d^2*sin(theta2) - 40000*tau + 135*theta2d^2*sin(theta2) - 24000*tau*cos(theta2) + 270*theta1d*theta2d*sin(theta2) + 81*theta1d^2*cos(theta2)*sin(theta2))/(81*cos(theta2)^2 - 225);
dXdt(8)=(54*sin(theta2)*theta1d^2 + 54*sin(theta2)*theta1d*theta2d + 27*sin(theta2)*theta2d^2 - 16000*tau)/(27*cos(theta2) - 45);
 



end
function tau=tau_step(X)
m=0.3;
g=10;
l=0.15;
mu=0.3;
k=2;
global sigma
x=X(1);y=X(2);theta1=X(3);theta2=X(4);
xd=X(5);yd=X(6);theta1d=X(7);theta2d=X(8);

RHS=(41*g*l*m + 2*l^2*m*theta1d^2*sin(theta1 + theta2) + 2*l^2*m*theta2d^2*sin(theta1 + theta2) - 54*l^2*m*theta1d^2*sin(theta1) - 18*l^2*m*theta1d^2*sin(theta1 - theta2) + 6*l^2*m*theta1d^2*sin(theta1 + 2*theta2) - 18*l^2*m*theta2d^2*sin(theta1 - theta2) - 9*g*l*m*cos(2*theta2) + 4*l^2*m*theta1d*theta2d*sin(theta1 + theta2) - 36*l^2*m*theta1d*theta2d*sin(theta1 - theta2))/(2*l*(27*cos(2*theta1) - 9*cos(2*theta2) - 3*cos(2*theta1 + 2*theta2) + 27*mu*sigma*sin(2*theta1) - 3*mu*sigma*sin(2*theta1 + 2*theta2) + 41));
LHS=(-(27*cos(theta1 - theta2) - 9*cos(theta1 + 2*theta2) - 3*cos(theta1 + theta2) + 81*cos(theta1))/(2*l*(27*cos(2*theta1) - 9*cos(2*theta2) - 3*cos(2*theta1 + 2*theta2) + 27*mu*sigma*sin(2*theta1) - 3*mu*sigma*sin(2*theta1 + 2*theta2) + 41)));

if LHS>0
    tau=-RHS/LHS;
    tau=tau-k;
else
        tau=-RHS/LHS;

    tau=tau+k;
end


if tau>10 || tau<-10
    tau=sign(tau)*10;
end

end
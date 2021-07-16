function dXdt=sys_fly(t,X)
global m g L

dXdt = zeros(8,1);
theta1 = X(3);
theta2 = X(4);
theta1d = X(7);
theta2d= X(8);

dXdt(1) = X(5);
dXdt(2) = X(6);
dXdt(3) = X(7);
dXdt(4) = X(8);

tau=tau_calc(t);

%    The rest of the function was generated by the Symbolic Math Toolbox version 8.6.
rhs = temp_fly_qdd(L,g,m,tau,theta1,theta2,theta1d,theta2d);
dXdt(5:8) = rhs;
end
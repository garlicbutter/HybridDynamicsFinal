function lambda_n_dot = lam_n_dot(t,X)
global L g m mu
theta1 = X(3);
theta2 = X(4);
theta1d = X(7);
theta2d= X(8);
sigma = sign(X(5));
tau=tau_calc(t);

qdd = temp_slip_qdd(L,g,m,mu,sigma,tau,theta1,theta2,theta1d,theta2d);
theta1dd = qdd(3);
theta2dd = qdd(4);
lambda_n_dot = temp_slip_lam_n_dot(L,g,m,mu,sigma,tau,theta1,theta2,theta1d,theta2d,theta1dd,theta2dd);
end


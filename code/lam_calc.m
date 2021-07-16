function [lambdan,lambdat,lambda_n_slip] = lam_calc(X,tau)

global sigma m g L mu
m=0.3;g=9.8;L=0.15;mu=0.3;
theta1 = X(3);
theta2 = X(4);
theta1d = X(7);
theta2d = X(8);

lambdan = temp_lam_n(L,g,m,tau,theta1,theta2,theta1d,theta2d);
lambdat = temp_lam_t(L,g,m,tau,theta1,theta2,theta1d,theta2d);
lambda_n_slip = temp_slip_lam_n(L,g,m,mu,sigma,tau,theta1,theta2,theta1d,theta2d);
end
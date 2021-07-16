function lambda_n_slip = temp_slip_lam_n(L,g,m,mu,sigma,tau,theta1,theta2,theta1d,theta2d)
%TEMP_SLIP_LAM_N
%    LAMBDA_N_SLIP = TEMP_SLIP_LAM_N(L,G,M,MU,SIGMA,TAU,THETA1,THETA2,THETA1D,THETA2D)

%    This function was generated by the Symbolic Math Toolbox version 8.6.
%    16-Jul-2021 18:43:55

t2 = theta1+theta2;
t3 = L.^2;
t4 = theta1.*2.0;
t5 = theta2.*2.0;
t6 = theta1d.^2;
t7 = theta2d.^2;
t10 = -theta2;
t8 = cos(t5);
t9 = sin(t2);
t11 = t2+theta2;
t12 = t10+theta1;
t13 = t2.*2.0;
t14 = sin(t12);
lambda_n_slip = ((tau.*cos(t2).*3.0+tau.*cos(t11).*9.0-tau.*cos(t12).*2.7e+1-tau.*cos(theta1).*8.1e+1+L.*g.*m.*4.1e+1+m.*t3.*t6.*t9.*2.0+m.*t3.*t7.*t9.*2.0-m.*t3.*t6.*t14.*1.8e+1-m.*t3.*t7.*t14.*1.8e+1+m.*t3.*t6.*sin(t11).*6.0-m.*t3.*t6.*sin(theta1).*5.4e+1-L.*g.*m.*t8.*9.0+m.*t3.*t9.*theta1d.*theta2d.*4.0-m.*t3.*t14.*theta1d.*theta2d.*3.6e+1).*(-1.0./2.0))./(L.*(t8.*9.0-cos(t4).*2.7e+1+cos(t13).*3.0-mu.*sigma.*sin(t4).*2.7e+1+mu.*sigma.*sin(t13).*3.0-4.1e+1));

function rhs = temp_fly_qdd(L,g,m,tau,theta1,theta2,theta1d,theta2d)
%TEMP_FLY_QDD
%    RHS = TEMP_FLY_QDD(L,G,M,TAU,THETA1,THETA2,THETA1D,THETA2D)

%    This function was generated by the Symbolic Math Toolbox version 8.6.
%    17-Jul-2021 05:35:35

t2 = cos(theta1);
t3 = cos(theta2);
t4 = sin(theta1);
t5 = sin(theta2);
t6 = theta1+theta2;
t7 = L.^2;
t8 = theta2.*2.0;
t9 = theta1d.^2;
t10 = theta2d.^2;
t12 = 1.0./L;
t16 = 1.0./m;
t17 = -theta2;
t11 = cos(t8);
t13 = 1.0./t7;
t14 = cos(t6);
t15 = sin(t6);
t18 = t6+theta2;
t21 = t17+theta1;
t19 = cos(t18);
t20 = sin(t18);
t22 = cos(t21);
t23 = sin(t21);
t24 = t11.*9.0;
t25 = t24-4.1e+1;
t26 = 1.0./t25;
rhs = [t12.*t16.*t26.*(t4.*tau.*8.1e+1-t15.*tau.*3.0-t20.*tau.*9.0+t23.*tau.*2.7e+1-m.*t2.*t7.*t9.*5.4e+1+m.*t7.*t9.*t14.*2.0+m.*t7.*t10.*t14.*2.0+m.*t7.*t9.*t19.*6.0-m.*t7.*t9.*t22.*1.8e+1-m.*t7.*t10.*t22.*1.8e+1+m.*t7.*t14.*theta1d.*theta2d.*4.0-m.*t7.*t22.*theta1d.*theta2d.*3.6e+1);-t12.*t16.*t26.*(t2.*tau.*8.1e+1-t14.*tau.*3.0-t19.*tau.*9.0+t22.*tau.*2.7e+1-L.*g.*m.*4.1e+1+m.*t4.*t7.*t9.*5.4e+1-m.*t7.*t9.*t15.*2.0-m.*t7.*t10.*t15.*2.0-m.*t7.*t9.*t20.*6.0+m.*t7.*t9.*t23.*1.8e+1+m.*t7.*t10.*t23.*1.8e+1+L.*g.*m.*t24-m.*t7.*t15.*theta1d.*theta2d.*4.0+m.*t7.*t23.*theta1d.*theta2d.*3.6e+1);(t13.*t16.*(tau.*-1.0e+1-t3.*tau.*6.0+m.*t5.*t7.*t9.*5.0+m.*t5.*t7.*t10.*5.0+m.*t3.*t5.*t7.*t9.*3.0+m.*t5.*t7.*theta1d.*theta2d.*1.0e+1).*-3.0)./(t3.^2.*9.0-2.5e+1);(t13.*t16.*(tau.*-4.0+m.*t5.*t7.*t9.*2.0+m.*t5.*t7.*t10+m.*t5.*t7.*theta1d.*theta2d.*2.0).*3.0)./(t3.*3.0-5.0)];

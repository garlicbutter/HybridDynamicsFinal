function out1 = temp_slip2(L,g,m,mu,sigma,tau,theta1,theta2,theta1d,theta2d)
%TEMP_SLIP2
%    OUT1 = TEMP_SLIP2(L,G,M,MU,SIGMA,TAU,THETA1,THETA2,THETA1D,THETA2D)

%    This function was generated by the Symbolic Math Toolbox version 8.6.
%    14-Jul-2021 20:05:14

t2 = cos(theta1);
t3 = cos(theta2);
t4 = sin(theta1);
t5 = sin(theta2);
t6 = theta1+theta2;
t7 = L.^2;
t8 = theta1.*2.0;
t9 = theta1.*3.0;
t10 = theta2.*2.0;
t11 = theta2.*3.0;
t12 = theta2.*4.0;
t13 = theta1d.^2;
t14 = theta2d.^2;
t24 = 1.0./m;
t25 = -theta2;
t15 = cos(t8);
t16 = cos(t9);
t17 = cos(t10);
t18 = cos(t11);
t19 = sin(t8);
t20 = sin(t9);
t21 = sin(t10);
t22 = sin(t11);
t23 = 1.0./t7;
t26 = -t10;
t27 = t6+theta2;
t28 = t6+theta1;
t29 = t6+t10;
t30 = t6+t8;
t31 = t6+t11;
t36 = t25+theta1;
t38 = t6.*2.0;
t42 = t6.*3.0;
t46 = t8+t25;
t32 = cos(t27);
t33 = cos(t28);
t34 = sin(t27);
t35 = sin(t28);
t37 = t26+theta1;
t39 = t6+t27;
t40 = t6+t28;
t41 = t6+t29;
t43 = t27+t38;
t47 = cos(t38);
t50 = sin(t38);
t53 = cos(t46);
t54 = sin(t46);
t44 = cos(t37);
t45 = sin(t37);
t48 = cos(t39);
t49 = cos(t40);
t51 = sin(t39);
t52 = sin(t40);
out1 = [(t23.*t24.*(t3.*tau.*8.352e+3-t18.*tau.*1.296e+3+m.*t7.*t13.*3.5154e+4+m.*t3.*t7.*t13.*1.107e+4+m.*t3.*t7.*t14.*1.107e+4-m.*t5.*t7.*t13.*1.2768e+4-m.*t5.*t7.*t14.*1.2768e+4-m.*t7.*t13.*t15.*3.51e+4-m.*t7.*t13.*t17.*3.402e+3-m.*t7.*t13.*t18.*4.86e+2-m.*t7.*t14.*t18.*4.86e+2-m.*t7.*t13.*t21.*2.412e+3+m.*t7.*t13.*t22.*1.512e+3+m.*t7.*t14.*t22.*1.512e+3-m.*t7.*t13.*t33.*4.662e+3-m.*t7.*t14.*t33.*4.662e+3+m.*t7.*t13.*t47.*3.402e+3+m.*t7.*t13.*t48.*3.96e+2+m.*t7.*t14.*t48.*3.96e+2-m.*t7.*t13.*t53.*6.318e+3-m.*t7.*t14.*t53.*6.318e+3-L.*g.*m.*sin(t31).*1.62e+2+L.*g.*m.*sin(t43).*2.7e+1-m.*t7.*t13.*cos(t41).*5.4e+1+m.*t7.*t13.*sin(t12).*3.24e+2-L.*g.*m.*t4.*4.149e+4+L.*g.*m.*t20.*9.477e+3+L.*g.*m.*t34.*4.905e+3+L.*g.*m.*t45.*2.835e+3-L.*g.*m.*t52.*1.08e+3+m.*t3.*t7.*theta1d.*theta2d.*2.214e+4-m.*t5.*t7.*theta1d.*theta2d.*2.5536e+4-m.*t7.*t18.*theta1d.*theta2d.*9.72e+2+m.*t7.*t22.*theta1d.*theta2d.*3.024e+3-m.*t7.*t33.*theta1d.*theta2d.*9.324e+3+m.*t7.*t48.*theta1d.*theta2d.*7.92e+2-m.*t7.*t53.*theta1d.*theta2d.*1.2636e+4-m.*mu.*sigma.*t5.*t7.*t13.*7.74e+2-m.*mu.*sigma.*t5.*t7.*t14.*7.74e+2+m.*mu.*sigma.*t7.*t13.*t19.*3.51e+4+m.*mu.*sigma.*t7.*t13.*t21.*1.998e+3+m.*mu.*sigma.*t7.*t13.*t22.*4.86e+2+m.*mu.*sigma.*t7.*t14.*t22.*4.86e+2+m.*mu.*sigma.*t7.*t13.*t35.*4.662e+3+m.*mu.*sigma.*t7.*t14.*t35.*4.662e+3-m.*mu.*sigma.*t7.*t13.*t50.*3.402e+3-m.*mu.*sigma.*t7.*t13.*t51.*3.96e+2-m.*mu.*sigma.*t7.*t14.*t51.*3.96e+2+m.*mu.*sigma.*t7.*t13.*t54.*6.318e+3+m.*mu.*sigma.*t7.*t14.*t54.*6.318e+3-L.*g.*m.*mu.*sigma.*cos(t31).*1.62e+2+L.*g.*m.*mu.*sigma.*cos(t43).*2.7e+1+m.*mu.*sigma.*t7.*t13.*sin(t41).*5.4e+1-L.*g.*m.*mu.*sigma.*t2.*2.2482e+4+L.*g.*m.*mu.*sigma.*t16.*9.477e+3+L.*g.*m.*mu.*sigma.*t32.*4.203e+3+L.*g.*m.*mu.*sigma.*t44.*1.377e+3-L.*g.*m.*mu.*sigma.*t49.*1.08e+3-m.*mu.*sigma.*t5.*t7.*theta1d.*theta2d.*1.548e+3+m.*mu.*sigma.*t7.*t22.*theta1d.*theta2d.*9.72e+2+m.*mu.*sigma.*t7.*t35.*theta1d.*theta2d.*9.324e+3-m.*mu.*sigma.*t7.*t51.*theta1d.*theta2d.*7.92e+2+m.*mu.*sigma.*t7.*t54.*theta1d.*theta2d.*1.2636e+4).*(-1.0./4.0))./(t17.*-2.205e+3+t17.^2.*1.62e+2+5.963e+3);(t23.*t24.*(tau.*2.68e+2-t17.*tau.*7.2e+1+m.*t7.*t13.*4.28e+2-m.*t7.*t14.*2.2e+1+m.*t3.*t7.*t14.*1.47e+2-m.*t5.*t7.*t13.*3.04e+2-m.*t5.*t7.*t14.*1.52e+2-m.*t7.*t13.*t15.*4.23e+2+m.*t7.*t14.*t15.*2.7e+1-m.*t7.*t13.*t17.*3.6e+1-m.*t7.*t14.*t17.*2.7e+1+m.*t7.*t13.*t22.*3.6e+1+m.*t7.*t14.*t22.*1.8e+1+m.*t7.*t13.*t33.*8.4e+1-m.*t7.*t14.*t33.*6.6e+1+m.*t7.*t13.*t47.*3.1e+1-m.*t7.*t13.*t48.*3.0+m.*t7.*t14.*t47.*2.2e+1-m.*t7.*t13.*t53.*8.1e+1-m.*t7.*t14.*t53.*8.1e+1-m.*t7.*theta1d.*theta2d.*4.4e+1+L.*g.*m.*sin(t6).*(2.69e+2./2.0)-L.*g.*m.*sin(t29).*9.0-L.*g.*m.*sin(t30).*(8.1e+1./2.0)+L.*g.*m.*sin(t36).*(6.3e+1./2.0)+L.*g.*m.*sin(t42).*(3.0./2.0)-L.*g.*m.*t4.*5.295e+2+L.*g.*m.*t20.*(2.43e+2./2.0)+L.*g.*m.*t34.*(6.3e+1./2.0)+L.*g.*m.*t45.*2.7e+1-L.*g.*m.*t52.*(9.0./2.0)+m.*t3.*t7.*theta1d.*theta2d.*2.94e+2-m.*t5.*t7.*theta1d.*theta2d.*3.04e+2+m.*t7.*t15.*theta1d.*theta2d.*5.4e+1-m.*t7.*t17.*theta1d.*theta2d.*5.4e+1+m.*t7.*t22.*theta1d.*theta2d.*3.6e+1-m.*t7.*t33.*theta1d.*theta2d.*1.32e+2+m.*t7.*t47.*theta1d.*theta2d.*4.4e+1-m.*t7.*t53.*theta1d.*theta2d.*1.62e+2+m.*mu.*sigma.*t5.*t7.*t13.*1.38e+2-m.*mu.*sigma.*t5.*t7.*t14.*1.5e+1+m.*mu.*sigma.*t7.*t13.*t19.*4.23e+2-m.*mu.*sigma.*t7.*t14.*t19.*2.7e+1+m.*mu.*sigma.*t7.*t13.*t21.*1.8e+1+m.*mu.*sigma.*t7.*t14.*t21.*2.7e+1-m.*mu.*sigma.*t7.*t13.*t35.*8.4e+1+m.*mu.*sigma.*t7.*t14.*t35.*6.6e+1-m.*mu.*sigma.*t7.*t13.*t50.*3.1e+1+m.*mu.*sigma.*t7.*t13.*t51.*3.0-m.*mu.*sigma.*t7.*t14.*t50.*2.2e+1+m.*mu.*sigma.*t7.*t13.*t54.*8.1e+1+m.*mu.*sigma.*t7.*t14.*t54.*8.1e+1+L.*g.*m.*mu.*sigma.*cos(t6).*(2.75e+2./2.0)-L.*g.*m.*mu.*sigma.*cos(t29).*9.0-L.*g.*m.*mu.*sigma.*cos(t30).*(8.1e+1./2.0)-L.*g.*m.*mu.*sigma.*cos(t36).*(9.9e+1./2.0)+L.*g.*m.*mu.*sigma.*cos(t42).*(3.0./2.0)-L.*g.*m.*mu.*sigma.*t2.*(5.73e+2./2.0)+L.*g.*m.*mu.*sigma.*t16.*(2.43e+2./2.0)+L.*g.*m.*mu.*sigma.*t32.*(4.5e+1./2.0)+L.*g.*m.*mu.*sigma.*t44.*2.7e+1-L.*g.*m.*mu.*sigma.*t49.*(9.0./2.0)-m.*mu.*sigma.*t5.*t7.*theta1d.*theta2d.*3.0e+1-m.*mu.*sigma.*t7.*t19.*theta1d.*theta2d.*5.4e+1+m.*mu.*sigma.*t7.*t21.*theta1d.*theta2d.*5.4e+1+m.*mu.*sigma.*t7.*t35.*theta1d.*theta2d.*1.32e+2-m.*mu.*sigma.*t7.*t50.*theta1d.*theta2d.*4.4e+1+m.*mu.*sigma.*t7.*t54.*theta1d.*theta2d.*1.62e+2).*(-3.0./2.0))./(t3.*2.55e+2+t3.^2.*2.52e+2-t3.^3.*1.08e+2-5.95e+2)];
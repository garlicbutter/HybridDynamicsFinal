function dXdt=sys_slip(t,X)
global m g L mu sigma
m=0.3;
g=10;
L=0.15;
mu = 0.3;

x = X(1);
y = X(2);
theta1 = X(3);
theta2 = X(4);
xd = X(5);
yd = X(6);
theta1d = X(7);
theta2d= X(8);

dXdt = zeros(8,1);
dXdt(1) = X(5);
dXdt(2) = X(6);
dXdt(3) = X(7);
dXdt(4) = X(8);

tau=tau_calc(t);
%    The rest of the function was generated by the Symbolic Math Toolbox version 8.6.
t2 = cos(theta1);
t3 = cos(theta2);
t4 = sin(theta1);
t5 = sin(theta2);
t6 = theta1+theta2;
t7 = L.^2;
t8 = theta1.*2.0;
t9 = theta2.*2.0;
t10 = theta1d.^2;
t11 = theta2d.^2;
t19 = 1.0./m;
t20 = -theta2;
t12 = cos(t8);
t13 = cos(t9);
t14 = sin(t8);
t15 = sin(t9);
t16 = 1.0./t7;
t17 = cos(t6);
t18 = sin(t6);
t21 = t6+theta2;
t22 = t6+theta1;
t27 = t20+theta1;
t28 = t3.*tau.*4.5e+1;
t29 = t6.*2.0;
t38 = mu.*sigma.*t5.*tau.*2.7e+1;
t39 = L.*g.*m.*t2.*1.17e+2;
t44 = L.*g.*m.*mu.*sigma.*t4.*1.17e+2;
t47 = m.*t5.*t7.*t11.*5.7e+1;
t49 = m.*t5.*t7.*theta1d.*theta2d.*1.14e+2;
t53 = m.*mu.*sigma.*t3.*t7.*theta1d.*theta2d.*5.4e+1;
t56 = m.*mu.*sigma.*t3.*t7.*t11.*2.7e+1;
t23 = cos(t21);
t24 = cos(t22);
t25 = sin(t21);
t26 = sin(t22);
t30 = cos(t27);
t31 = sin(t27);
t32 = t13.*1.8e+1;
t33 = -t28;
t34 = cos(t29);
t35 = sin(t29);
t37 = t12.*8.1e+1;
t40 = -t39;
t41 = mu.*sigma.*t14.*8.1e+1;
t48 = -t44;
t59 = m.*t7.*t10.*t14.*8.1e+1;
t65 = m.*mu.*sigma.*t7.*t10.*t12.*-8.1e+1;
t36 = -t32;
t42 = t34.*3.0;
t43 = t24.*tau.*2.7e+1;
t50 = L.*g.*m.*t23.*9.0;
t51 = mu.*sigma.*t35.*3.0;
t52 = mu.*sigma.*t26.*tau.*2.7e+1;
t57 = L.*g.*m.*mu.*sigma.*t25.*9.0;
t58 = m.*t7.*t26.*theta1d.*theta2d.*5.4e+1;
t60 = m.*t7.*t11.*t26.*2.7e+1;
t61 = m.*mu.*sigma.*t7.*t24.*theta1d.*theta2d.*5.4e+1;
t62 = m.*mu.*sigma.*t7.*t10.*t37;
t63 = m.*mu.*sigma.*t7.*t11.*t24.*2.7e+1;
t45 = -t42;
t46 = -t43;
t54 = -t51;
t55 = -t52;
t64 = -t61;
t66 = -t63;
t67 = t36+t37+t41+t45+t54+1.36e+2;
t68 = 1.0./t67;
rhs = [(t19.*t68.*(t18.*tau.*4.8e+1-t31.*tau.*5.4e+1+m.*t2.*t7.*t10.*3.0e+2+m.*t7.*t10.*t17.*4.4e+1+m.*t7.*t11.*t17.*4.4e+1-m.*t7.*t10.*t23.*6.0+m.*t7.*t10.*t30.*5.4e+1+m.*t7.*t11.*t30.*5.4e+1-mu.*sigma.*t17.*tau.*4.8e+1+mu.*sigma.*t30.*tau.*5.4e+1-L.*g.*m.*t14.*8.1e+1+L.*g.*m.*t35.*3.0-L.*g.*m.*mu.*sigma.*1.36e+2+m.*t7.*t17.*theta1d.*theta2d.*8.8e+1+m.*t7.*t30.*theta1d.*theta2d.*1.08e+2+m.*mu.*sigma.*t4.*t7.*t10.*3.0e+2+m.*mu.*sigma.*t7.*t10.*t18.*4.4e+1+m.*mu.*sigma.*t7.*t11.*t18.*4.4e+1-m.*mu.*sigma.*t7.*t10.*t25.*6.0+m.*mu.*sigma.*t7.*t10.*t31.*5.4e+1+m.*mu.*sigma.*t7.*t11.*t31.*5.4e+1+L.*g.*m.*mu.*sigma.*t32-L.*g.*m.*mu.*sigma.*t34.*3.0+L.*g.*m.*mu.*sigma.*t37+m.*mu.*sigma.*t7.*t18.*theta1d.*theta2d.*8.8e+1+m.*mu.*sigma.*t7.*t31.*theta1d.*theta2d.*1.08e+2))./L;0.0;t16.*t19.*t68.*(t33+t38+t40+t46+t47+t48+t49+t50+t53+t55+t56+t57+t58+t59+t60+t64+t65+t66+m.*t5.*t7.*t10.*5.7e+1+m.*t7.*t10.*t15.*1.8e+1+m.*t7.*t10.*t26.*2.7e+1+m.*mu.*sigma.*t7.*t10.*8.1e+1+m.*mu.*sigma.*t3.*t7.*t10.*2.7e+1-m.*mu.*sigma.*t7.*t10.*t24.*2.7e+1);-t16.*t19.*t68.*(t33+t38+t40+t46+t47+t48+t49+t50+t53+t55+t56+t57+t58+t59+t60+t64+t65+t66-tau.*1.23e+2-t12.*tau.*8.1e+1+m.*t5.*t7.*t10.*1.5e+2+m.*t7.*t10.*t15.*3.6e+1+m.*t7.*t11.*t15.*1.8e+1+m.*t7.*t10.*t26.*3.6e+1+m.*t7.*t10.*t35.*3.0+m.*t7.*t11.*t35.*3.0-mu.*sigma.*t14.*tau.*8.1e+1+L.*g.*m.*t17.*1.5e+1-L.*g.*m.*t30.*2.7e+1+m.*mu.*sigma.*t7.*t10.*8.4e+1+m.*mu.*sigma.*t7.*t11.*3.0+m.*t7.*t15.*theta1d.*theta2d.*3.6e+1+m.*t7.*t35.*theta1d.*theta2d.*6.0+m.*mu.*sigma.*t3.*t7.*t10.*3.6e+1-m.*mu.*sigma.*t7.*t10.*t24.*3.6e+1-m.*mu.*sigma.*t7.*t10.*t34.*3.0-m.*mu.*sigma.*t7.*t11.*t34.*3.0+m.*mu.*sigma.*t7.*theta1d.*theta2d.*6.0+L.*g.*m.*mu.*sigma.*t18.*1.5e+1-L.*g.*m.*mu.*sigma.*t31.*2.7e+1-m.*mu.*sigma.*t7.*t34.*theta1d.*theta2d.*6.0)];

dXdt(5:8) = rhs;
end
function [lam_n,lam_t,lam_n_slip,lam_n_slip_dot] = lam_calc(X,tau)

global sigma m g L mu
m=0.3;g=9.8;L=0.15;mu=0.3;
x = X(1);
y = X(2);
theta1 = X(3);
theta2 = X(4);
xd = X(5);
yd = X(6);
theta1d = X(7);
theta2d = X(8);

t2 = theta1+theta2;
t3 = theta1.*2.0;
t4 = theta2.*2.0;
t5 = theta1d.^2;
t6 = theta2d.^2;
t9 = -theta2;
t7 = cos(t4);
t8 = sin(t2);
t10 = t9+theta1;
t11 = sin(t10);
lam_n = (m.*(g.*-6.8e+1+g.*t7.*9.0+g.*cos(t3).*(8.1e+1./2.0)-g.*cos(t2.*2.0).*(3.0./2.0)+L.*t5.*sin(theta1).*1.5e+2+L.*t5.*t8.*2.2e+1+L.*t6.*t8.*2.2e+1+L.*t5.*t11.*2.7e+1+L.*t6.*t11.*2.7e+1-L.*t5.*sin(t2+theta2).*3.0+L.*t8.*theta1d.*theta2d.*4.4e+1+L.*t11.*theta1d.*theta2d.*5.4e+1))./(t7.*1.8e+1-6.7e+1);

t2 = theta1+theta2;
t3 = theta1.*2.0;
t4 = theta2.*2.0;
t5 = theta1d.^2;
t6 = theta2d.^2;
t8 = -theta2;
t7 = cos(t2);
t9 = t8+theta1;
t10 = cos(t9);
lam_t = (m.*(g.*sin(t2.*2.0).*(3.0./2.0)-g.*sin(t3).*(8.1e+1./2.0)+L.*t5.*t7.*2.2e+1+L.*t6.*t7.*2.2e+1+L.*t5.*t10.*2.7e+1+L.*t6.*t10.*2.7e+1-L.*t5.*cos(t2+theta2).*3.0+L.*t5.*cos(theta1).*1.5e+2+L.*t7.*theta1d.*theta2d.*4.4e+1+L.*t10.*theta1d.*theta2d.*5.4e+1))./(cos(t4).*1.8e+1-6.7e+1);

t2 = theta1+theta2;
t3 = L.^2;
t4 = theta1.*2.0;
t5 = theta2.*2.0;
t6 = theta1d.^2;
t7 = theta2d.^2;
t10 = -theta2;
t8 = cos(t5);
t9 = sin(t2);
t11 = t10+theta1;
t12 = t2.*2.0;
t13 = sin(t11);
lam_n_slip = (tau.*cos(t2).*-1.5e+1+tau.*cos(t11).*2.7e+1-L.*g.*m.*8.9e+1+m.*t3.*t6.*t9.*1.3e+1+m.*t3.*t7.*t9.*1.3e+1+m.*t3.*t6.*t13.*2.7e+1+m.*t3.*t7.*t13.*2.7e+1-m.*t3.*t6.*sin(t2+theta2).*3.0+m.*t3.*t6.*sin(theta1).*1.23e+2+L.*g.*m.*t8.*9.0+m.*t3.*t9.*theta1d.*theta2d.*2.6e+1+m.*t3.*t13.*theta1d.*theta2d.*5.4e+1)./(L.*(t8.*1.8e+1-cos(t4).*8.1e+1+cos(t12).*3.0-mu.*sigma.*sin(t4).*8.1e+1+mu.*sigma.*sin(t12).*3.0-1.36e+2));


t2 = theta1+theta2;
t3 = L.^2;
t4 = theta1.*2.0;
t5 = theta2.*2.0;
t6 = theta1d.^2;
t7 = theta2d.^2;
t10 = -theta2;
t8 = cos(t5);
t9 = sin(t2);
t11 = t10+theta1;
t12 = t2.*2.0;
t13 = sin(t11);
lam_n_slip_dot = (tau.*cos(t2).*-1.5e+1+tau.*cos(t11).*2.7e+1-L.*g.*m.*8.9e+1+m.*t3.*t6.*t9.*1.3e+1+m.*t3.*t7.*t9.*1.3e+1+m.*t3.*t6.*t13.*2.7e+1+m.*t3.*t7.*t13.*2.7e+1-m.*t3.*t6.*sin(t2+theta2).*3.0+m.*t3.*t6.*sin(theta1).*1.23e+2+L.*g.*m.*t8.*9.0+m.*t3.*t9.*theta1d.*theta2d.*2.6e+1+m.*t3.*t13.*theta1d.*theta2d.*5.4e+1)./(L.*(t8.*1.8e+1-cos(t4).*8.1e+1+cos(t12).*3.0-mu.*sigma.*sin(t4).*8.1e+1+mu.*sigma.*sin(t12).*3.0-1.36e+2));
end
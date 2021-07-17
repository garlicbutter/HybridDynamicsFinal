function Xnew = impact_law(Xold)
% frictional fully plastic 
global m L mu 

X = Xold(end,:);
q = X(1:4).';
q_dot = X(5:8).';

theta1 = X(3);
theta2 = X(4);

t2 = cos(theta1);
t3 = cos(theta2);
t4 = sin(theta1);
t5 = theta1+theta2;
t6 = L.^2;
t7 = m.*2.0;
t8 = t2.*3.0;
t9 = t3.*3.0;
t10 = t4.*3.0;
t11 = cos(t5);
t12 = sin(t5);
t13 = t9+2.0;
t14 = L.*m.*t11;
t15 = L.*m.*t12;
t16 = t8+t11;
t17 = t10+t12;
t18 = -t15;
t19 = L.*m.*t16;
t20 = L.*m.*t17;
t21 = m.*t6.*t13.*(2.0./3.0);
t22 = -t20;
M = reshape([t7,0.0,t22,t18,0.0,t7,t19,t14,t22,t19,m.*t6.*(t13+3.0).*(4.0./3.0),t21,t18,t14,t21,m.*t6.*(4.0./3.0)],[4,4]);

W = [1,0,0,0;0,1,0,0];
A = W/M* W.';
v_minus = W*q_dot;
%Chatterjee
Lam_1 = [0;-v_minus(2)/A(2,2)];
Lam_2 = -A\v_minus;
%fully plastic
e_n = 0; e_t = 0;
%desired impulse
lam_hat = (1+e_n)*Lam_1 + (1+e_t)*(Lam_2 - Lam_1); 
L_t = lam_hat(1);
L_n = lam_hat(2);

if abs(L_t)<= mu*L_n
    kappa = 1 + e_t; % case 1
else
    kappa = (mu*(1+e_n)*Lam_1(2))/(abs(Lam_2(1))-mu*(Lam_2(2)-Lam_1(2))); % case 2
end

lambda = (1+e_n)*Lam_1 + kappa*(Lam_2 - Lam_1);
q_dot_new = q_dot + M\W.'*lambda;
Xnew = [q;q_dot_new];
end


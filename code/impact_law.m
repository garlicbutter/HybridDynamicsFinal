function Xnew = impact_law(Xold)
% frictional fully plastic 
global m g L mu 
Ic = m*l^2/3;

X = Xold(end,:);
q = X(1:4).';
q_dot = X(5:8).';

x = X(1);
y = X(2);
theta1 = X(3);
theta2 = X(4);
xd = X(5);
yd = X(6); 
theta1d = X(7);
theta2d = X(8);

t2 = cos(theta1);
t3 = cos(theta2);
t4 = sin(theta1);
t5 = theta1+theta2;
t6 = L.^2;
t7 = m.*2.0;
t8 = t2.*3.0;
t9 = t3.*6.0;
t10 = t4.*3.0;
t11 = cos(t5);
t12 = sin(t5);
t13 = t9+5.0;
t14 = L.*m.*t11;
t15 = L.*m.*t12;
t16 = t8+t11;
t17 = t10+t12;
t18 = -t15;
t19 = L.*m.*t16;
t20 = L.*m.*t17;
t21 = (m.*t6.*t13)./3.0;
t22 = -t20;
M = reshape([t7,0.0,t22,t18,0.0,t7,t19,t14,t22,t19,m.*t6.*(t13+6.0).*(2.0./3.0),t21,t18,t14,t21,m.*t6.*(5.0./3.0)],[4,4]);


W = [1,0,0,0;0,1,0,0];
A = W/M* W.';
v_minus = W*q_dot;
%Chatterjee Law
lamb1 = [0;-v_minus(2)/A(2,2)];
lamb2 = -inv(A) * v_minus;
en = 0; et = 0; %fully plastic
Lambda_hat = (1+en)*lamb1 + (1+et)*(lamb2 - lamb1); %desired impulse
Lt = Lambda_hat(1); Ln = Lambda_hat(2);
if abs(Lt)<= mu*Ln
    kappa = 1 + et;
    fprintf('case 1') % if Lambda_t_hat <= mu Lambda_n
else
    kappa = (mu*(1+en)*lamb1(2))/(abs(lamb2(1))-mu*(lamb2(2)-lamb1(2)));
    fprintf('case 2') % else
end 
Lambda = (1+en)*lamb1 + kappa*(lamb2 - lamb1);
q_plus_dot = q_dot + inv(Mc) * Wc.'* Lambda;
Xnew = [q;q_plus_dot];
end


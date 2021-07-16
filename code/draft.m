clc;clear;close all;
syms x y theta1 theta2
syms xd yd theta1d theta2d
syms xdd ydd theta1dd theta2dd
syms m L g mu

q=[x;y;theta1;theta2];
qd=[xd;yd;theta1d;theta2d];
qdd=[xdd; ydd; theta1dd; theta2dd];

Ic = m*(2*L)^2/12;
r1c = [x+L*cos(theta1);y+L*sin(theta1)];
r2c = [x+2*L*cos(theta1)+L*cos(theta1+theta2); y+2*L*sin(theta1)+L*sin(theta1+theta2)];
rCG = (r1c+r2c)/2;
v1c=jacobian(r1c,q)*qd;
v2c=jacobian(r2c,q)*qd;

T = 1/2 * ((m*v1c.'*v1c + m*v2c.'*v2c) + Ic * theta1d^2 + Ic*(theta1d+theta2d)^2);
T = simplify(T);
V = 2*m*g*rCG(2);
V = simplify(V);

syms tau
Fq = [0;0;0;tau];

M = simplify(hessian(T,qd));
B = simplify(jacobian(gradient(T,qd),q)*qd-gradient(T,q));
G = simplify(gradient(V,q));

W = [1 0 0 0;0 1 0 0;];
Wd = [0 0 0 0; 0 0 0 0;];
lambda = simplify( (W*(M\W.'))\(W*(M\(B+G-Fq))));
lambdat = lambda(1);
lambdan = lambda(2);
%% stick
rhs = simplify(M\(W.'*lambda+Fq-G-B));
matlabFunction(rhs,'file','temp_stick_qdd')
matlabFunction(lambdat,'file','temp_lam_t')
matlabFunction(lambdan,'file','temp_lam_n')
%% slip
syms sigma mu
Wt = [1 0 0 0];
Wn = [0 1 0 0];
Wtd = [0 0 0 0];
Wnd = [0 0 0 0];

alpha = Wn*(M\(Wn-sigma*mu*Wt).');
beta = Wn*(M\(B+G-Fq));
% lambda_n_slippage = beta/alpha;
% alpha = Wn/M*(Wn-sigma*mu*Wt).';
% beta = Wn/M*(B+G-Fq)-Wnd*qd;
lambda_n_slip = simplify(beta/alpha);
lambda_n_dot = jacobian(lambda_n_slip,q)*qd+jacobian(lambda_n_slip,qd)*qdd;

matlabFunction(lambda_n_slip,'file','temp_slip_lam_n')
matlabFunction(lambda_n_dot,'file','temp_slip_lam_n_dot')

rhs =  simplify( M\(-B-G+(Wn-sigma*mu*Wt).'*lambda_n_slip+Fq) ) ;
matlabFunction(rhs,'file','temp_slip_qdd')
rhs =  simplify( M\(-B-G+(Wn-sigma*mu*Wt).'*lambda_n_slip+Fq) ) ;
matlabFunction(rhs(3:4),'file','temp_slip_thetadd')
%% fly
rhs = simplify(M\(Fq-B-G));
matlabFunction(rhs,'file','temp_fly_qdd')
%% Inertia matrix
matlabFunction(M,'file','temp_M')
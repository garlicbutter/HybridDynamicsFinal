clc;clear;close all;
syms x y theta1 theta2
syms xd yd theta1d theta2d
syms xdd ydd theta1dd theta2dd
syms m L g mu

Ic = m*(2*L)^2/12;
r1c = [x+L*cos(theta1);y+L*sin(theta1)];
r2c = [x+2*L*cos(theta1)+L*cos(theta1+theta2); y+2*L*sin(theta1)+L*sin(theta1+theta2)];
rCG = (r1c+r2c)/2;
rP = [x; y];
vP = [xd; yd;];
v1c = [xd-L*theta1d*sin(theta1);
       yd+L*theta1d*cos(theta1)];
v2c = [xd-2*L*theta1d*sin(theta1)-L*(theta1d+theta2d)*sin(theta1+theta2);
       yd+2*L*theta1d*cos(theta1)+L*(theta1d+theta2d)*cos(theta1+theta2)];
T = m/2 * (v1c.'*v1c + v2c.'*v2c) + Ic * theta1d^2 + Ic*(theta1d+theta2d)^2;
T = simplify(T);
V = 2*m*g*rCG(2);
V = simplify(V);

syms tau
Fq = [0;0;0;tau];

q=[x;y;theta1;theta2];
qd=[xd;yd;theta1d;theta2d];
qdd=[xdd; ydd; theta1dd; theta2dd];

M=simplify(hessian(T,qd));
dV_dq=gradient(V,q);
dT_dqd=gradient(T,qd);
ddt_dT_dqd=jacobian(dT_dqd,q)*qd+jacobian(dT_dqd,qd)*qdd;
dT_dq=gradient(T,q);
Eqs=simplify(ddt_dT_dqd-dT_dq+dV_dq);
G=simplify(jacobian(V,q).');
B=simplify(expand(Eqs - G - M*qdd));

W = [1 0 0 0;0 1 0 0;];
Wd = [0 0 0 0; 0 0 0 0;];
lambda = simplify((W/M*W.')\(W/M*(B+G-Fq)-Wd*qd));
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

alpha = Wn/M*(Wn-sigma*mu*Wt).';
beta = Wn/M*(B+G-Fq)-Wnd*qd;
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
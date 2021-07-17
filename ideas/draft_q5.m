clc;clear;close all;
syms x y theta1 theta12
syms xd yd theta1d theta12d
syms xdd ydd theta1dd theta12dd
syms m L g mu

q=[x;y;theta1;theta12];
qd=[xd;yd;theta1d;theta12d];
qdd=[xdd; ydd; theta1dd;theta12dd];

Ic = m*(2*L)^2/12;
r1c = [x+L*cos(theta1);y+L*sin(theta1)];
r2c = [x+2*L*cos(theta1)+L*cos(theta12); y+2*L*sin(theta1)+L*sin(theta12)];
rCG = (r1c+r2c)/2;
v1c=jacobian(r1c,q)*qd;
v2c=jacobian(r2c,q)*qd;
T = 1/2 * ((m*v1c.'*v1c + m*v2c.'*v2c) + Ic * theta1d^2 + Ic*(theta12d)^2);
T = simplify(T);
V = 2*m*g*rCG(2);
V = simplify(V);

syms tau
Fq = [0;0;0;tau];

M = simplify(hessian(T,qd));
B = simplify(jacobian(gradient(T,qd),q)*qd-gradient(T,q));
G = simplify(gradient(V,q));


%% fly
rhs = M*qdd+B+G;
rhs2 = simplify(rhs(4)) -tau;

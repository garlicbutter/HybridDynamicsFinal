function [value,isterminal,direction]=events_stick2(t,X)
tau=calc_tau(t,X,3);
sigma=1;
mu=0.3; l=0.15;
[vt,lambt,lambn,lam_n, lam_ndot]=lam(X,sigma,tau);
Q=X(2);
R=X(2)+2*l*sin(X(3)+X(4));
value=[abs(lambt)-mu*lambn;Q;R];

isterminal=[1;1;1];
direction=[-1;-1;-1];
end
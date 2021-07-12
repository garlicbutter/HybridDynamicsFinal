function [value,isterminal,direction]=events_stick(t,X)
tau=calc_tau(t,X,1);
sigma=1;
mu=0.3;
[vt,lambt,lambn,lam_n, lam_ndot]=lam(X,sigma,tau);
% value=abs(lambt)-mu*lambn;

% isterminal=1;
% direction=1;
value=[mu*lambn-lambt;-mu*lambn-lambt];
isterminal=[1;1];
direction=[-1;1];
end
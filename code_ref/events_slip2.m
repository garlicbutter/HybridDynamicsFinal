function [value,isterminal,direction]=events_slip2(t,X)
global sigma 
mu=0.3;l=0.15;
p=10;
tau=calc_tau(t,X,3);
[vt,lambt,lambn,lam_n, lam_ndot]=lam(X,sigma,tau);
if lambn<=0 && lam_ndot<=0
    p=0;
end
k=10;
if abs(lambt)<mu*lambn && vt==0
    k=0;
end
Q=X(2);
R=X(2)+2*l*sin(X(3)+X(4));
sigma=sign(vt);

value=[p,k,Q,R];
isterminal=[1,1,1,1];
direction=[-1,-1,-1,-1];

end
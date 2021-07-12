function [value,isterminal,direction]=events_slip(t,X)

global sigma 
mu=0.3;
event_sepa=10;
tau=calc_tau(t,X,1);
[vt,lambt,lambn,lam_n, lam_ndot]=lam(X,sigma,tau);

if lam_n<=0 && lam_ndot<=0
    event_sepa=0;
end

k=10;
if abs(lambt)<mu*lambn && vt==0
    k=0;
end
sigma=sign(vt);

value=[lam_n,k];
isterminal=[1,1];
direction=[-1,-1];

end
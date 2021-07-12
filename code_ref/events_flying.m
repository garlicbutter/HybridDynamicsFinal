function [value,isterminal,direction]=events_flying(t,X)

l=0.15; k=10;

d1=X(2)-2*l*sin(X(3)); ddot=X(6)-2*l*cos(X(3))*X(7);
d2=X(2)+2*l*sin(X(3)+X(4));
if d1<=0 && ddot<0
      k=0;
end

if X(2)<=0
      k=0;
end

if d2<=0
      k=0;
end

value=k;
isterminal=1;
direction=-1;
end
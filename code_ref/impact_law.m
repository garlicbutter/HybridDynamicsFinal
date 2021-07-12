function Xnew=impact_law(Xold)
syms x y  theta1 theta2  xd yd theta1d theta2d xdd ydd theta1dd theta2dd  u tau real
m=0.3;
g=10;
l=0.15;
q=[x,y,theta1,theta2].';
qd=[xd,yd,theta1d,theta2d].';
I=m*l^2/3;
r1=[x-l*cos(theta1),y-l*sin(theta1)].';
r2=[x+l*cos(theta1+theta2),y+l*sin(theta1+theta2)].';
v1=jacobian(r1,q)*qd;
v2=jacobian(r2,q)*qd;
w1 = theta1d;
w2 = theta1d+theta2d;
T = simplify(0.5*(m*(v1.'*v1)+(m*(v2.'*v2))+I*(w1)^2+I*(w2)^2));
M=simplify(hessian(T,qd));
wt =[1,0,2*l*sin(theta1),0];
wn =[0,1,-2*l*cos(theta1),0];


qc = Xold(1:4).'; 
qcd =Xold(5:8).';
Mc = subs(M,[x,y,theta1,theta2],[qc(1),qc(2),qc(3),qc(4)]);
Mc =double(Mc);
wtc = subs(wt,[x,y,theta1,theta2],[qc(1),qc(2),qc(3),qc(4)]);
wtc =double(wtc);
wnc = subs(wn,[x,y,theta1,theta2],[qc(1),qc(2),qc(3),qc(4)]);
wnc =double(wnc);
Wc = [wtc;wnc];
A = (Wc*inv(Mc)*(Wc.'));
v_minus = Wc*qcd;
LAMBDA2 = (-inv(A)*v_minus);
LAMBDA1 = [0,-v_minus(2)/A(2,2)].';
en = 0;
et = 0;
LAMBDA_H=(1+en)*LAMBDA1+(1+et)*(LAMBDA2-LAMBDA1);
u=0.3;
if(abs(LAMBDA_H(1))<=u*LAMBDA_H(2))
    kappa = 1+et;
    fprintf('case 1')
else 
    kappa = (u*(1+en)*LAMBDA1(2))/(abs(LAMBDA2(1))-u*(LAMBDA2(2)-LAMBDA1(2)));
    fprintf('case 2')
end
LAMBDA =(1+en)*LAMBDA1+kappa*(LAMBDA2-LAMBDA1);

% v_plus = v_minus+A*LAMBDA;
qcd_plus = qcd+inv(Mc)*Wc.'*LAMBDA;
Xnew = [qc;qcd_plus];
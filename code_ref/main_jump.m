clear all
close all
%% taking off
global sigma ti
sigma=1;
tf=5; mu=0.3;
ang1=110;
ang2=-73;

l=0.15;theta1_0=ang1*pi/180; theta2_0=ang2*pi/180;
X = [0 2*l*sin(theta1_0) theta1_0 theta2_0 0 0 0 0];
t0=0; y=zeros(1,8); t=zeros(1,1); 
tau1=calc_tau(0,X,1);
[vt1,lambt1,lambn1, lam_n1, lam_ndot1]=lam(X,sigma,tau1);
if abs(lambt1)<mu*lambn1
    ie=2; 
else 
    ie=1;
end
while t0<tf
    if ie==2
    interval = linspace(t0,tf,10000); 
    option=odeset('Events',@events_stick,'RelTol', 1e-12, 'AbsTol', 1e-12);
    [t1,y1] = ode45(@(t,X) sys_stick(t,X),interval,X,option);
    t0=t1(end); X=y1(end,:); y=[y;y1];t=[t;t1];
    end
    t_slip=t0;
    if t0==tf
        break
    end
    interval = linspace(t0,tf,10000); 
    option=odeset('Events',@events_slip,'RelTol', 1e-12, 'AbsTol', 1e-12);
    [t1,y1,te,ye,ie] = ode45(@(t,X) sys_slip(t,X,sigma),interval,X,option);
    
    t0=t1(end); X=y1(end,:); y=[y;y1];t=[t;t1]; taup=calc_tau(t0,X,1);
    [vt,lambt,lambn,lam_n, lam_ndot]=lam(X,sigma,taup);
    if ie==1 %& lam_ndot<0
        ti=t0;
        break;
    end
end

y=y(2:end,:);t=t(2:end,:);

%% torque/lambda n
n=max(size(y));
for i=1:n
    if t(i)<=ti
        tau(i)=calc_tau(t(i),y(i,:),1);
    end
    if t(i)>ti
        tau(i)=calc_tau(t(i),y(i,:),2);
    end
    
end

vt=y(:,5) + 2.*l.*y(:,7).*sin(y(:,3));
for i=1:n
sigs(i)=sign(vt(i));
end
ind=max(find(t==t_slip));
for i=1:n
    
[vt(i),lambt(i),lambn(i), lam_n(i), lam_ndot(i)]=lam(y(i,:),sigs(i),tau(i));
    Hc(i)=(9*(3*cos(y(i,4)) + 5)*(2*y(i,7) + y(i,8)))/8000;
end
for i=1:ind
    lam_n(i)=lambn(i);
end
index=min(find(lam_n<0));
y=y(1:index,:);t=t(1:index,:);
y0=y(end,:); t0=t(end);
ti=t0;
%% flying
dis1=max(y(:,1)-2*l*cos(y(:,3)));
interval = linspace(t0,tf,10000);
option=odeset('Events',@events_flying,'RelTol', 1e-10, 'AbsTol', 1e-10);
[t1,y1] = ode45(@(t,X) sys_flying(t,X),interval,y0,option);
t0=t1(end); Xold=y1(end,:); y=[y;y1]; t=[t;t1];

n=max(size(y));
%% 
n=max(size(y));

X_p=[y(:,1)-2*l*cos(y(:,3)),y(:,2)-2*l*sin(y(:,3))];
X_q=[y(:,1),y(:,2)];
X_r=[y(:,1)+2*l*cos(y(:,3)+y(:,4)),y(:,2)+2*l*sin(y(:,3)+y(:,4))];

%% center of mass
% h=animatedline;
% XC=y(:,1) + (l*cos(y(:,3) + y(:,4)))/2 - (l*cos(y(:,3)))/2;
% YC=y(:,2) + (l*sin(y(:,3) + y(:,4)))/2 - (l*sin(y(:,3)))/2;
% for i=1:n
%     addpoints(h,XC(i),YC(i))
%     ylim([0,2])
%     xlim([-1,1])
%     axis equal
%     drawnow
% end
% 
%% impact
X=impact_law(Xold);
vt=X(5) + 2.*l.*X(7).*sin(X(3));
mu=0.3;
sigma=sign(vt);
taup=calc_tau(t0,X,3);
[vt,lambt,lambn,lam_n, lam_ndot]=lam(X,sigma,taup);

if abs(mu*lambn-lambt)<=0 && vt==0
    ie=2;
end
y_a=zeros(1,8);t_a=zeros(1,1); 

while t0<tf
    if ie==1
    interval = linspace(t0,tf,10000);
    option=odeset('Events',@events_slip2,'RelTol', 1e-12, 'AbsTol', 1e-12);
    [t11,y11,te,ye,ie] = ode45(@(t,X) sys_slip2(t,X,sigma),interval,X,option);
    
    t0=t11(end); X=y11(end,:); y_a=[y_a;y11];...
        t_a=[t_a;t11]; taup=calc_tau(t0,X,3);
    [vt,lambt,lambn,lam_n, lam_ndot]=lam(X,sigma,taup);
    end
    
    if ie==1 & lam_ndot<0
        fprintf('fly again!')
        break
    end
    if ie==3 
        fprintf('Q touches ground')
        break
    end
    if ie==4
        fprintf('R touches ground')
        break
    end
    
    if ie==2
        interval = linspace(t0,tf,10000); 
        option=odeset('Events',@events_stick2,'RelTol', 1e-12, 'AbsTol', 1e-12);
        [t1,y1] = ode45(@(t,X) sys_stick(t,X),interval,X,option);
        t0=t1(end); X=y1(end,:); y_a=[y_a;y1];...
            t_a=[t_a;t1];
    end
    
    if ie==2
        fprintf('Q touches ground')
        break
    end
    if ie==3
        fprintf('R touches ground')
        break
    end
end
y_a=y_a(2:end,:);t_a=t_a(2:end,:);
n1s=size(y_a);n1=n1s(1);

X_p_a=[y_a(:,1)-2*l*cos(y_a(:,3)),y_a(:,2)-2*l*sin(y_a(:,3))];
X_q_a=[y_a(:,1),y_a(:,2)];
X_r_a=[y_a(:,1)+2*l*cos(y_a(:,3)+y_a(:,4)),y_a(:,2)+2*l*sin(y_a(:,3)+y_a(:,4))];

%%
% for i=1:n
%     if t(i)<=ti
%         tau(i)=calc_tau(t(i),y(i,:),1);
%     else
%         tau(i)=calc_tau(t(i),y(i,:),2);
%     end
% end
% for i=1:n1
%     tau=[tau,calc_tau(t_a(i),y_a(i,:),3)];
% end
% 
% plot([t;t_a],tau,'*')

%% animation 
figure
for i=1:n
    plot([X_r(i,1) X_q(i,1)],[X_r(i,2) X_q(i,2)],'linewidth',2,'color','black')
    hold on
    plot([X_p(i,1) X_q(i,1)],[X_p(i,2) X_q(i,2)],'linewidth',2,'color','black')
    hold off
    
    ylim([0,1])
    axis equal
    drawnow 
end
for i=1:n1
    plot([X_r_a(i,1) X_q_a(i,1)],[X_r_a(i,2) X_q_a(i,2)],'linewidth',2,'color','black')
    hold on
    plot([X_p_a(i,1) X_q_a(i,1)],[X_p_a(i,2) X_q_a(i,2)],'linewidth',2,'color','black')
    hold off

    ylim([0,1])
    axis equal
    drawnow
end
%%
distance=y_a(end,1)-dis1
xp=X_p(end,1); xr=X_r(end,1); yr=X_r(end,2); yp=X_p(end,2);
angle=atan((xp-xr)/(yr-yp))*180/pi
%%
Y=[y;y_a];T=[t;t_a];td=t(end);
nn=length(T);
for i=1:nn
    if T(i)<=ti
        tau(i)=calc_tau(T(i),Y(i,:),1);
    end
    if T(i)>ti && T(i)<=td
        tau(i)=calc_tau(T(i),Y(i,:),2);
    end
    if T(i)>=td
        tau(i)=calc_tau(T(i),Y(i,:),3);
    end
end
%%
plot(T,tau,'linewidth',2)
xlabel('time[sec]')
ylabel('torque[Nm]')
legend('Torque')
%% x y theta1 theta2
figure
plot(T,Y(:,1),'linewidth',2)
hold on
plot(T,Y(:,2),'linewidth',2)
legend('x','y')
xlabel('time')
ylabel('distance')

figure
plot(T,Y(:,3),'linewidth',2)
hold on
plot(T,Y(:,4),'linewidth',2)
legend('\theta_1','\theta_2')
xlabel('time')
ylabel('angle')

%% 2
Vt=Y(:,5) + 2*l*Y(:,7).*sin(Y(:,3));
for i=1:nn
sigs(i)=sign(Vt(i));
sigs(i)=1;
end
ind_pos=min(find(T==td));
for i=1:nn
[lambt(i),lambn(i), lam_n(i)]=lambdas(Y(i,:),sigs(i),tau(i));
    %Hc(i)=(9*(3*cos(y(i,4)) + 5)*(2*y(i,7) + y(i,8)))/8000;
end
% for i=ind_pos:nn
%     lam_n(i)=abs(lam_n(i));
%     lambn(i)=abs(lambn(i));
% end
figure
plot(T,lambn,'linewidth',2)
hold on
plot(T,zeros(nn,1),'linewidth',2)
legend('\lambda_n','zero line')
xlabel('time')
ylabel('\lambda')


%% 3

kk=lambt./lambn;
for i =1:nn
if abs(kk(i))>0.3
    kk(i)=sign(kk(i))*0.3;
else
    kk(i)=kk(i);
end
end
figure
plot(T,kk,'linewidth',2)

hold on
plot(T,0.3*ones(nn,1),'--','linewidth',2)
hold on
plot(T,-0.3*ones(nn,1),'--','linewidth',2)
legend('\lambda_t/\lambda_n','+\mu','-\mu')
xlabel('time')
ylabel('\lambda')
ylim([-0.4,0.4])
%%
%% 4
figure
plot([X_r(1,1) X_q(1,1)],[X_r(1,2) X_q(1,2)],'linewidth',3,'color','red')
hold on
plot([X_p(1,1) X_q(1,1)],[X_p(1,2) X_q(1,2)],'linewidth',3,'color','red')

axis equal
hold on
ki=4;
kip=(n-mod(n,ki))/ki;
for kk=1:ki
    i=kip*kk;
    plot([X_r(i,1) X_q(i,1)],[X_r(i,2) X_q(i,2)],'--','linewidth',0.8,'color','green')
    hold on
    plot([X_p(i,1) X_q(i,1)],[X_p(i,2) X_q(i,2)],'--','linewidth',0.8,'color','green')
    
end

ii=max(find(t==ti));
plot([X_r(ii,1) X_q(ii,1)],[X_r(ii,2) X_q(ii,2)],'linewidth',3,'color','black')
hold on
plot([X_p(ii,1) X_q(ii,1)],[X_p(ii,2) X_q(ii,2)],'linewidth',3,'color','black')


plot([X_r(end,1) X_q(end,1)],[X_r(end,2) X_q(end,2)],'linewidth',3,'color','blue')
hold on
plot([X_p(end,1) X_q(end,1)],[X_p(end,2) X_q(end,2)],'linewidth',3,'color','blue')

plot([X_r_a(1,1) X_q_a(1,1)],[X_r_a(1,2) X_q_a(1,2)],'linewidth',3,'color','cyan')
hold on
plot([X_p_a(1,1) X_q_a(1,1)],[X_p_a(1,2) X_q_a(1,2)],'linewidth',3,'color','cyan')
axis equal
hold on
ki=2;
kip=(n1-mod(n1,ki))/ki;
for kk=1:ki
    i=kip*kk;
    plot([X_r_a(i,1) X_q_a(i,1)],[X_r_a(i,2) X_q_a(i,2)],'--','linewidth',0.8,'color','green')
    hold on
    plot([X_p_a(i,1) X_q_a(i,1)],[X_p_a(i,2) X_q_a(i,2)],'--','linewidth',0.8,'color','green')
end
plot([X_r_a(end,1) X_q_a(end,1)],[X_r_a(end,2) X_q_a(end,2)],'linewidth',3,'color','blue')
hold on
plot([X_p_a(end,1) X_q_a(end,1)],[X_p_a(end,2) X_q_a(end,2)],'linewidth',3,'color','blue')

xlabel('X[m]')
ylabel('Y[m]')


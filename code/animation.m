clc;clear all;close all;

global sigma m g L mu

sigma = 1;
m=0.3;
g=9.80665;
L=0.15;

% initial condition
phi = deg2rad(40); % 0~105
theta1_0 = deg2rad(45) + phi;
theta2_0 = -2 * phi;
rQ0 = [2*L*cos(theta1_0);2*L*sin(theta1_0)];
rR0 = rQ0 + [2*L*cos(theta1_0+theta2_0);2*L*sin(theta1_0+theta2_0)];
if rQ0(2)>rR0(2)
   error("P higher than R, Choose another phi")
end

t_0 = 0;
t_f = 5;
ie_stick = 0; %, 1 = separation, 2 = slip_positive 3 = slip_negative 
ie_slip = 1; % 1 = stop_slip, 2 = speed seperation, 3 = point separation
ie_fly = 0; % 1 = stop_fly, 2 = stop_simu 3 = PR- y60deg angle
dt = 0.0005;
X0 = [0, 0, theta1_0, theta2_0, 0, 0, 0, 0];

%initialize
t_tot(1) = t_0;
X_tot(1,:) = X0;

%simulation loop
while  ie_fly ~= 2
    % Event stick
    if ie_slip==1
        tspan = t_tot(end):dt:t_f;
        X0 = X_tot(end,:);
        op_stick = odeset('RelTol',1e-10,'AbsTol',1e-10,'Events',@events_stick);
        [t_stick,X_stick,te_stick,Xe_stick,ie_stick] = ode45(@(t,X) sys_stick(t,X),tspan,X0,op_stick);
        t_tot = [t_tot;t_stick(2:end)];
        X_tot = [X_tot;X_stick(2:end,:)];
        if ie_stick == 1
            break
        end
    end
    % Event slip
    if ie_stick == 2 || ie_stick == 3 || ie_fly == 1
        mu = 0.3;
        tspan = t_tot(end):dt:t_f;
        X0 = X_tot(end,:);
        op_slip = odeset('RelTol',1e-10,'AbsTol',1e-10,'Events',@events_slip);
        [t_slip,X_slip,te_slip,Xe_slip,ie_slip] = ode45(@(t,X) sys_slip(t,X),tspan,X0,op_slip);
        t_tot = [t_tot;t_slip(2:end)];
        X_tot = [X_tot;X_slip(2:end,:)];
        if ie_slip == 3
            break
        end
    end
    % Event fly
    if ie_slip == 2
        tspan = t_tot(end):dt:t_f;
        X0 = X_tot(end,:)   ;
        op_fly = odeset('RelTol',1e-10,'AbsTol',1e-10,'Events',@events_fly);
        [t_fly,X_fly,te_fly,Xe_fly,ie_fly] = ode45(@(t,X) sys_fly(t,X),tspan,X0,op_fly);
        t_tot = [t_tot;t_fly(2:end)];
        X_tot = [X_tot;X_fly(2:end,:)];
    end
    % Impact
    if ie_fly == 1
        X0 = impact_law(Xe_fly);
        X_tot(end,:) = X0; 
    end
    if ie_fly == 3
       disp("line PR breached the angle constraint")
       break 
    end
end

% state space to link position
n=size(X_tot,1);
rP=[X_tot(:,1),X_tot(:,2)];
rQ=[X_tot(:,1)+2*L*cos(X_tot(:,3)),X_tot(:,2)+2*L*sin(X_tot(:,3))];
rR=rQ + [2*L*cos(X_tot(:,3)+X_tot(:,4)),2*L*sin(X_tot(:,3)+X_tot(:,4))];
rCG = [X_tot(:,1) + ( L*cos(X_tot(:,3)+X_tot(:,4)) ) / 2 + (3*L*cos(X_tot(:,3))) / 2 ;
       X_tot(:,2) + ( L*sin(X_tot(:,3)+X_tot(:,4)) ) / 2 + (3*L*sin(X_tot(:,3))) / 2];

disp("Start Sticking:"+num2str(0))
disp("Start Slipping:"+num2str(te_stick))
disp("Start flying"+num2str(te_slip))
disp("First Impact"+num2str(te_fly))
disp("ie-stick:"+num2str(ie_stick)+"   ,1 = separation, 2 = slip_positive 3 = slip_negative ")
disp("ie-slip:"+num2str(ie_slip)+"    ,1 = stop slip, 2 = speed seperation, 3 = point separation")
disp("ie-fly:"+num2str(ie_fly)+"     ,1 = stop fly, 2 = second impact 3 = PR- y60deg angle")
distance = min([rP(end,1), rQ(end,1), rR(end,1)]);
disp("Distance:"+num2str(distance))

% Animation
figure(1)
for k = 1:n
    plot([rR(k,1) rQ(k,1)],[rR(k,2) rQ(k,2)],'linewidth',3,'color','blue')
    hold on
    plot([rP(k,1) rQ(k,1)],[rP(k,2) rQ(k,2)],'linewidth',3,'color','red')
    hold off
    yline(-0.02,'linewidth',1,'color','black')
    lim = 1.5;
    xlim([-0.3,-0.3+lim])
    ylim([-0.05,0.05+lim])

    txt = "time[s]:" + num2str(t_tot(k));
    text(lim*0.2,lim*0.9,txt)
    drawnow limitrate
    grid on
    grid minor
end

figure(2)
for k = 1:n
    tau_plot(k) = tau_calc(t_tot(k));
end
plot(t_tot,tau_plot)
title("\tau")
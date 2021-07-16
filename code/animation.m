clc;clear;close all;
global sigma m g L mu
global time0 time1 time2 time3
global f1 f2 f3 f4
sigma = 1;
m=0.3;
g=9.80665;
L=0.15;
mu = 0.3;

% initial condition
phi = deg2rad(55); % angle between link1 and line PR
inclined_theta = deg2rad(55);% angle between line PR and x axis

% initialization
t_0 = 0;
t_f = 5;
dt = 0.0005;
theta1_0 = inclined_theta + phi;
theta2_0 = -2 * phi;
rQ0 = [2*L*cos(theta1_0);2*L*sin(theta1_0)];
rR0 = rQ0 + [2*L*cos(theta1_0+theta2_0);2*L*sin(theta1_0+theta2_0)];
if rQ0(2)>rR0(2)
   error("P higher than R, Choose another phi")
end
X0 = [0, 0, theta1_0, theta2_0, 0, 0, 0, 0];
t_tot(1) = t_0;
X_tot(1,:) = X0;
ie_slip = 2; % start out as sticking
ie_stick = 0;
ie_fly = 0;
% event_stick:value = [lam_t-mu*lam_n, -lam_t-mu*lam_n, r_R(2), r_Q(2), lam_n];
% event_slip :value = [lam_n_slip, vt ,r_R(2),r_Q(2)];
% event_fly  :value = [stop_fly,r_R(2),r_Q(2),angle_constraint];
t_event_change = [0];
event_order = ["Start"];

% simulation loop when the robot hasn't left the ground
while true 
    % Event stick before flying
    if ie_slip==2
        disp("sticking: "+num2str(t_tot(end)))
        tspan = t_tot(end):dt:t_f;
        X0 = X_tot(end,:);
        op_stick = odeset('RelTol',1e-10,'AbsTol',1e-10,'Events',@events_stick);
        [t_stick,X_stick,te_stick,Xe_stick,ie_stick] = ode45(@(t,X) sys_stick(t,X),tspan,X0,op_stick);
        t_tot = [t_tot;t_stick(2:end)];
        X_tot = [X_tot;X_stick(2:end,:)];
        t_event_change = [t_event_change te_stick];
        event_order = [event_order;'Sticked before flying'];
        if ie_stick == 3
            error("point R touched the ground while sticking before flying\n Run animation_regarless_of_error.m to see the animation")
        end
        if ie_stick == 4
            error("point Q touched the ground while sticking before flying\n Run animation_regarless_of_error.m to see the animation")
        end
    end
    
    % Event slip before flying
    if  ie_stick == 1 || ie_stick == 2
        disp("slipping: "+num2str(t_tot(end)))
        tspan = t_tot(end):dt:t_f;
        X0 = X_tot(end,:);
        op_slip = odeset('RelTol',1e-9,'AbsTol',1e-9,'Events',@events_slip);
        [t_slip,X_slip,te_slip,Xe_slip,ie_slip] = ode45(@(t,X) sys_slip(t,X),tspan,X0,op_slip);
        t_event_change = [t_event_change te_slip];
        event_order = [event_order;'Slipped before flying'];
        t_tot = [t_tot;t_slip(2:end)];
        if ie_slip == 3
            error("point R touched the ground while slipping before flying\n Run animation_regarless_of_error.m to see the animation")
        end
        if ie_slip == 4
            error("point Q touched the ground while slipping before flying\n Run animation_regarless_of_error.m to see the animation")
        end
    end
   
    % Event fly
    if ie_slip == 1 || ie_stick == 5
        disp("flying:   "+num2str(t_tot(end)))
        tspan = t_tot(end):dt:t_f;
        X0 = X_tot(end,:);
        op_fly = odeset('RelTol',1e-10,'AbsTol',1e-9,'Events',@events_fly);
        [t_fly,X_fly,te_fly,Xe_fly,ie_fly] = ode45(@(t,X) sys_fly(t,X),tspan,X0,op_fly);
        event_order = [event_order;'Flied'];
        t_event_change = [t_event_change te_fly(end)];
        t_tot = [t_tot;t_fly(2:end)];
        X_tot = [X_tot;X_fly(2:end,:)];
        if ie_fly(end) == 2
            error("point R landed on the ground first\n Run animation_regarless_of_error.m to see the animation")
        end
        if ie_fly(end) == 3
            error("point Q landed on the ground first\n Run animation_regarless_of_error.m to see the animation")
        end
        if ie_fly(end) == 4
            error("line PR breached the angle constraint at time: "+ num2str(te_fly))
        end
        break
    end
end
% Impact
if ie_fly == 1
    % it landed on the ground
    X0 = impact_law(Xe_fly);
    X_tot(end,:) = X0;
    % reset ie_handle.
    ie_stick = 1; % assume sliding after landing
    ie_slip = 1;
else
    error("Landed without impact?")
end

% simulation loop when the robot landed
while true
    % Event Slip
    if  ie_stick == 1 || ie_stick == 2
        disp("contact+slipping: "+num2str(t_tot(end)))
        tspan = t_tot(end):dt:t_f;
        X0 = X_tot(end,:);
        op_slip = odeset('RelTol',1e-10,'AbsTol',1e-10,'Events',@events_slip);
        [t_slip,X_slip,te_slip,Xe_slip,ie_slip] = ode45(@(t,X) sys_slip(t,X),tspan,X0,op_slip);
        t_event_change = [t_event_change te_slip];
        event_order = [event_order;'Slipped after landing'];
        t_tot = [t_tot;t_slip(2:end)];
        X_tot = [X_tot;X_slip(2:end,:)];
        if ie_slip == 2
            error("It left the ground again after it landed")
        end
        if ie_slip == 3
            event_order(end) = "Point R touched the ground after slipping";
            break
        end
        if ie_slip == 4
            event_order(end) = "Point Q touched the ground after slipping";
            break
        end
    end
    % Event stick
    if ie_slip==1
        disp("contact+sticking: "+num2str(t_tot(end)))
        tspan = t_tot(end):dt:t_f;
        X0 = X_tot(end,:);
        op_stick = odeset('RelTol',1e-10,'AbsTol',1e-10,'Events',@events_stick);
        [t_stick,X_stick,te_stick,Xe_stick,ie_stick] = ode45(@(t,X) sys_stick(t,X),tspan,X0,op_stick);
        t_tot = [t_tot;t_stick(2:end)];
        X_tot = [X_tot;X_stick(2:end,:)];
        t_event_change = [t_event_change te_stick];
        event_order = [event_order;'Sticked after landing'];
        if ie_stick == 3
            event_order(end) = "Point R touched the ground after sticking";
            break
        end
        if ie_stick == 4
            event_order(end) = "Point Q touched the ground after sticking";
            break
        end
        if ie_stick == 5
            error("It left the ground again after it landed")
        end
    end
end

disp("Simulation terminated")
% state space to link position
n=size(X_tot,1);
rP=[X_tot(:,1),X_tot(:,2)];
rQ=[X_tot(:,1)+2*L*cos(X_tot(:,3)),X_tot(:,2)+2*L*sin(X_tot(:,3))];
rR=rQ + [2*L*cos(X_tot(:,3)+X_tot(:,4)),2*L*sin(X_tot(:,3)+X_tot(:,4))];
rCG_x = [X_tot(:,1) + ( L*cos(X_tot(:,3)+X_tot(:,4)) ) / 2 + (3*L*cos(X_tot(:,3))) / 2];
rCG_y = [X_tot(:,2) + ( L*sin(X_tot(:,3)+X_tot(:,4)) ) / 2 + (3*L*sin(X_tot(:,3))) / 2];

clc
for i = 1:length(t_event_change)
   txt = sprintf('%-25s %1.3f',event_order(i),t_event_change(i));
   disp(txt+["s"]) 
end
disp("ie-stick:"+num2str(ie_stick(end)))
disp("ie-slip: "+num2str(ie_slip(end)))
disp("ie-fly:  "+num2str(ie_fly(end)))
distance = min([rP(end,1), rQ(end,1), rR(end,1)]);
disp("Jump Distance:"+num2str(distance))
f1_char = func2str(f1);
f2_char = func2str(f2);
f3_char = func2str(f3);
f4_char = func2str(f4);
f1_char = f1_char(5:end);
f2_char = f2_char(5:end);
f3_char = f3_char(5:end);
f4_char = f4_char(5:end);
file_name = "tau_trial_and_error.xls";
savedata = {time0,time1,time2,time3,f1_char,f2_char,f3_char,f4_char,distance,rad2deg(phi),rad2deg(inclined_theta)};
writecell(savedata,file_name,'WriteMode','append')
disp("Saved the data to: " + file_name) 
tau_plot = zeros(1,length(t_tot));
for k = 1:n
    tau_plot(k) = tau_calc(t_tot(k));
end
% Animation
figure(1)
for k = 1:n
    plot([rR(k,1) rQ(k,1)],[rR(k,2) rQ(k,2)],'linewidth',2,'color','blue')
    grid on 
    grid minor
    hold on
    plot([rP(k,1) rQ(k,1)],[rP(k,2) rQ(k,2)],'linewidth',2,'color','red')
    plot(rCG_x(k),rCG_y(k),'b*')
    yline(0,'linewidth',3,'color','black')
    hold off
    lim = 1.5;
    xlim([-0.3,-0.3+lim])
    ylim([-0.05,0.05+lim])
    txt  = "time   :" + num2str(round(t_tot(k),3)) + "s";
    txt2 = "Torque :" + num2str(tau_plot(k))+" Nm";
    text(lim*0.2,lim*0.9,txt)
    text(lim*0.2,lim*0.85,txt2)
    drawnow limitrate
end


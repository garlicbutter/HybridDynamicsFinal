clc;clear all;close all;

global sigma m g L mu
global time0 time1 time2 time3
global f1 f2 f3 f4
sigma = 1;
m=0.3;
g=9.80665;
L=0.15;

% initial condition
phi = deg2rad(40);
inclined_theta = deg2rad(40);
theta1_0 = inclined_theta + phi;
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
t_event_change = [0];
event_order = ["Start:   "];

% simulation loop when the robot hasn't left the ground
while  ie_fly ~= 1 
    if ie_fly == 0 
        % Event stick
        if ie_slip==1
            disp("sticking: "+num2str(t_tot(end)))
            tspan = t_tot(end):dt:t_f;
            X0 = X_tot(end,:);
            op_stick = odeset('RelTol',1e-10,'AbsTol',1e-10,'Events',@events_stick);
            [t_stick,X_stick,te_stick,Xe_stick,ie_stick] = ode45(@(t,X) sys_stick(t,X),tspan,X0,op_stick);
            t_tot = [t_tot;t_stick(2:end)];
            X_tot = [X_tot;X_stick(2:end,:)];
            t_event_change = [t_event_change te_stick];
            event_order = [event_order;'Sticked: '];
            if ie_stick == 1
                break
            end
        end
        % Event slip
        if  ie_stick == 2 || ie_stick == 3
            disp("slipping: "+num2str(t_tot(end)))
            mu = 0.3;
            tspan = t_tot(end):dt:t_f;
            X0 = X_tot(end,:);
            op_slip = odeset('RelTol',1e-10,'AbsTol',1e-10,'Events',@events_slip);
            [t_slip,X_slip,te_slip,Xe_slip,ie_slip] = ode45(@(t,X) sys_slip(t,X),tspan,X0,op_slip);
            t_event_change = [t_event_change te_slip];
            event_order = [event_order;'Slipped: '];
            t_tot = [t_tot;t_slip(2:end)];
            X_tot = [X_tot;X_slip(2:end,:)];
            if ie_slip == 3
                break
            end
        end
    end
    % Event fly
    if ie_slip == 2
        disp("flying:   "+num2str(t_tot(end)))
        tspan = t_tot(end):dt:t_f;
        X0 = X_tot(end,:)   ;
        op_fly = odeset('RelTol',1e-10,'AbsTol',1e-10,'Events',@events_fly);
        [t_fly,X_fly,te_fly,Xe_fly,ie_fly] = ode45(@(t,X) sys_fly(t,X),tspan,X0,op_fly);
        event_order = [event_order;'flied:   '];
        t_event_change = [t_event_change te_fly];
        t_tot = [t_tot;t_fly(2:end)];
        X_tot = [X_tot;X_fly(2:end,:)];
        if ie_fly == 3
            disp("line PR breached the angle constraint at time: "+ num2str(te_fly))
            break 
        end
        %reset status since it's in the air.
        ie_stick = 0;
        ie_slip  = 0;
    end
    % Impact
    if ie_fly == 1 % it landed on the ground
        disp("Impact!   "+num2str(t_tot(end)))
        X0 = impact_law(Xe_fly);
        X_tot(end,:) = X0;
    end
end

% reset ie_handle.
ie_stick = 2; %, 1 = separation, 2 = slip_positive 3 = slip_negative 
ie_slip = 1; % 1 = stop_slip, 2 = speed seperation, 3 = point separation
ie_fly = 0; % 1 = stop_fly, 2 = stop_simu 3 = PR- y60deg angle
% simulation loop when the robot hasn't left the ground
while ie_slip~=3 || ie_stick~=1
    %Event Slip
    if  ie_stick == 2 || ie_stick == 3
        disp("contact+slipping: "+num2str(t_tot(end)))
        mu = 0.3;
        tspan = t_tot(end):dt:t_f;
        X0 = X_tot(end,:);
        op_slip = odeset('RelTol',1e-10,'AbsTol',1e-10,'Events',@events_slip);
        [t_slip,X_slip,te_slip,Xe_slip,ie_slip] = ode45(@(t,X) sys_slip(t,X),tspan,X0,op_slip);
        t_event_change = [t_event_change te_slip];
        event_order = [event_order;'Slipped: '];
        t_tot = [t_tot;t_slip(2:end)];
        X_tot = [X_tot;X_slip(2:end,:)];
        if ie_slip == 2
            error("It left the ground again after it landed")
        end
        if ie_slip == 3
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
        event_order = [event_order;'Sticked: '];
        if ie_stick == 1
            break
        end
    end
end

% state space to link position
n=size(X_tot,1);
rP=[X_tot(:,1),X_tot(:,2)];
rQ=[X_tot(:,1)+2*L*cos(X_tot(:,3)),X_tot(:,2)+2*L*sin(X_tot(:,3))];
rR=rQ + [2*L*cos(X_tot(:,3)+X_tot(:,4)),2*L*sin(X_tot(:,3)+X_tot(:,4))];
rCG_x = [X_tot(:,1) + ( L*cos(X_tot(:,3)+X_tot(:,4)) ) / 2 + (3*L*cos(X_tot(:,3))) / 2];
rCG_y = [X_tot(:,2) + ( L*sin(X_tot(:,3)+X_tot(:,4)) ) / 2 + (3*L*sin(X_tot(:,3))) / 2];

clc
for i = 1:length(t_event_change)
   disp(event_order(i) + num2str(t_event_change(i))) 
end
if ie_fly == 3
    disp("line PR breached the angle constraint at time: "+ num2str(te_fly))
end
disp("ie-stick:"+num2str(ie_stick)+"   ,1 = separation, 2 = slip_positive     3 = slip_negative ")
disp("ie-slip: "+num2str(ie_slip)+"   ,1 = stop slip,  2 = speed seperation, 3 = point separation")
disp("ie-fly:  "+num2str(ie_fly)+"   ,1 = stop fly,   2 = second impact     3 = PR- y60deg angle")
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
if ie_fly ~= 3
writecell(savedata,file_name,'WriteMode','append')
end

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


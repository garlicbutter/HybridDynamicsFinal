clc;clear;close all;
global sigma m g L mu
global time0 time1 time2 time3
global f1 f2 f3 f4
sigma = 1;
m=0.3;
g=10;
L=0.15;
mu = 0.3;

% initial condition
phi = deg2rad(54); % angle between link1 and line PR
inclined_theta = deg2rad(55);% angle between line PR and x axis
theta1_0 = inclined_theta + phi;
theta2_0 = -2 * phi;
% theta1_0 = deg2rad(45);
% theta2_0 = deg2rad(45);
% phi = theta2_0 / (-2) ;
% inclined_theta = theta1_0 - phi;
% initialization
global dt t_f
t_0 = 0;
t_f = 3;
dt = 0.0005;

rQ0 = [2*L*cos(theta1_0);2*L*sin(theta1_0)];
rR0 = rQ0 + [2*L*cos(theta1_0+theta2_0);2*L*sin(theta1_0+theta2_0)];
if rQ0(2)>rR0(2)
   error("P higher than R, Choose another phi")
end
X0 = [0, 0, theta1_0, theta2_0, 0, 0, 0, 0];
t_tot(1) = t_0;
X_tot(1,:) = X0;
[lam_n,lam_t,lam_n_slip] = lam_calc(X0,tau_calc(t_0));
if lam_n < 0
    error("Initial condition will make it fly immediately")
elseif mu*lam_n > abs(lam_t)
    ie_slip = 2; % start out as sticking
    ie_stick = 0;
    ie_fly = 0;
else
    ie_slip = 0; % start out as slipping
    ie_stick = 1;
    ie_fly = 0;
end

% event_stick:value = [lam_t-mu*lam_n, -lam_t-mu*lam_n, r_R(2), r_Q(2), lam_n];
% event_slip :value = [lam_n_slip, vt ,r_R(2),r_Q(2)];
% event_fly  :value = [stop_fly,r_R(2),r_Q(2),angle_constraint];
t_event_change = [0];
event_order = ["Start"];
disp("Started: "+num2str(t_tot(end)))
while true
    [t_tot,...
     X_tot,...
     ie_slip,...
     ie_stick,...
     ie_fly,...
     t_event_change,...
     event_order]          =    ground_simulation(t_tot,X_tot,ie_slip,ie_stick,ie_fly,t_event_change,event_order);
 
    if ie_slip(end)==3 || ie_slip(end)==4 || ie_stick(end)==3 || ie_stick(end)==4
        break
    end
        
    lam_n = -1;     %just for keep running the simulation
    lam_n_slip = -1;%just for keep running the simulation
    
    while lam_n_slip < 0
        [t_tot,...
         X_tot,...
         ie_fly,...
         t_event_change,...
         event_order]          =    air_simulation(t_tot,X_tot,t_event_change,event_order);
        if ie_fly(end) ~= 1 
            animation_regarless_of_error
            error("ie_fly")
        end
        % Impact
        X0 = impact_law(X_tot(end,:));
        X_tot(end,:) = X0;
        [lam_n,lam_t,lam_n_slip] = lam_calc(X_tot(end,:),tau_calc(t_tot(end)));
    end
    disp("flied:   "+num2str(t_tot(end)))% if ie_fly(end) == 4
    event_order = [event_order;'Flied'];
    t_event_change = [t_event_change t_tot(end)];
    
    if mu*lam_n > abs(lam_t)
        ie_slip = 2; % start out as sticking
        ie_stick = 0;
        ie_fly = 0;
    else
        ie_slip = 0; % start out as slipping
        ie_stick = 1;
        ie_fly = 0;
    end
end

rP=[X_tot(end,1),X_tot(end,2)];
rQ=[X_tot(end,1)+2*L*cos(X_tot(end,3)),X_tot(end,2)+2*L*sin(X_tot(end,3))];
rR=rQ + [2*L*cos(X_tot(end,3)+X_tot(end,4)),2*L*sin(X_tot(end,3)+X_tot(end,4))];
if ie_slip == 3
    d_end = min([rP(end,1), rR(end,1)]);
elseif ie_slip == 4
    d_end = min([rP(end,1), rQ(end,1)]);
elseif ie_stick == 3
    d_end = min([rP(end,1), rR(end,1)]);
elseif ie_stick == 4
    d_end = min([rP(end,1), rQ(end,1)]);
else
    error("how did you get here without Q,R landing")
end
distance_jump = d_end;


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
% disp("ie-stick:"+num2str(ie_stick(end)))
% disp("ie-slip: "+num2str(ie_slip(end)))
% disp("ie-fly:  "+num2str(ie_fly(end)))
disp("Jump Distance:"+num2str(distance_jump))
f1_char = func2str(f1);
f2_char = func2str(f2);
f3_char = func2str(f3);
f4_char = func2str(f4);
f1_char = f1_char(5:end);
f2_char = f2_char(5:end);
f3_char = f3_char(5:end);
f4_char = f4_char(5:end);
file_name = "tau_trial_and_error.xls";
savedata = {time0,time1,time2,time3,f1_char,f2_char,f3_char,f4_char,distance_jump,rad2deg(phi),rad2deg(inclined_theta)};
writecell(savedata,file_name,'WriteMode','append')
disp("Saved the data to: " + file_name) 
tau_plot = zeros(1,length(t_tot));
for k = 1:n
    tau_plot(k) = tau_calc(t_tot(k));
end
% Animation
figure(1)
for k = 1:3:n
    plot([rR(k,1) rQ(k,1)],[rR(k,2) rQ(k,2)],'linewidth',3,'color','blue')
    grid on 
    grid minor
    hold on
    plot([rP(k,1) rQ(k,1)],[rP(k,2) rQ(k,2)],'linewidth',3,'color','red')
    plot(rCG_x(k),rCG_y(k),'b*')
    yline(0,'linewidth',2,'color','black')
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
close all
% state space to link position
n=size(X_tot,1);
rP=[X_tot(:,1),X_tot(:,2)];
rQ=[X_tot(:,1)+2*L*cos(X_tot(:,3)),X_tot(:,2)+2*L*sin(X_tot(:,3))];
rR=rQ + [2*L*cos(X_tot(:,3)+X_tot(:,4)),2*L*sin(X_tot(:,3)+X_tot(:,4))];
rCG_x = [X_tot(:,1) + ( L*cos(X_tot(:,3)+X_tot(:,4)) ) / 2 + (3*L*cos(X_tot(:,3))) / 2];
rCG_y = [X_tot(:,2) + ( L*sin(X_tot(:,3)+X_tot(:,4)) ) / 2 + (3*L*sin(X_tot(:,3))) / 2];

tau_plot = zeros(1,length(t_tot));
for k = 1:n
    tau_plot(k) = tau_calc(t_tot(k));
end
% Animation
%% plot tau
figure(1)
movegui("northeast")
tau_plot = zeros(1,length(t_tot));
for k = 1:length(t_tot)
    tau_plot(k) = tau_calc(t_tot(k));
end
plot(t_tot,tau_plot)
title("Actuation torque")
xlabel('time [s]')
ylabel('Torque [Nm]')
grid on
%% plot x,y:
X = X_tot(:,1);
Y = X_tot(:,2);
theta1 = X_tot(:,3);
theta2 = X_tot(:,4);
%% plot theta
figure(2)
movegui("south")
plot(t_tot,theta1+theta2/2,'LineWidth',2,'DisplayName','\theta_1')
hold on
yline(deg2rad(30))
yline(deg2rad(150))
title("\theta_1 +  \theta_2 /2 over time")
xlabel('Time [sec]')
ylabel('\theta [rad]')
legend('Location','best')
grid on

%%
figure(3)
movegui("northwest")
for k = 1:3:n
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



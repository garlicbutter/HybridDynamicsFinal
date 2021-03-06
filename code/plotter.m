% plot all the required plots. you need to run animation.m first
close all
clc
%% plot movement
figure(1)
movegui("northwest")
for k = 1:50:length(t_tot)
    if k == 1
        plot([rR(k,1) rQ(k,1)],[rR(k,2) rQ(k,2)],'linewidth',3,'color','blue')
        hold on
        plot([rP(k,1) rQ(k,1)],[rP(k,2) rQ(k,2)],'linewidth',3,'color','red')
    elseif k ~= length(t_tot)
        hold on
        plot([rR(k,1) rQ(k,1)],[rR(k,2) rQ(k,2)],'--b')
        hold on
        plot([rP(k,1) rQ(k,1)],[rP(k,2) rQ(k,2)],'--r')
    else
        hold on
        plot([rR(k,1) rQ(k,1)],[rR(k,2) rQ(k,2)],'linewidth',3,'color','blue')
        hold on
        plot([rP(k,1) rQ(k,1)],[rP(k,2) rQ(k,2)],'linewidth',3,'color','red')
    end
    ylim([0,0.7])
    axis equal
  
end
hold on
plot([rR(n,1) rQ(n,1)],[rR(n,2) rQ(n,2)],'linewidth',3,'color','blue')
hold on
plot([rP(n,1) rQ(n,1)],[rP(n,2) rQ(n,2)],'linewidth',3,'color','red')
title("Snapshots of movement")
xlabel('x [m]')
ylabel('y [m]')
grid on
axis equal
saveas(gcf,"../img/movement.png")
%% plot tau
figure(2)
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
saveas(gcf,"../img/tau.png")
%% plot x,y:
X = X_tot(:,1);
Y = X_tot(:,2);
theta1 = X_tot(:,3);
theta2 = X_tot(:,4);
figure(3)
movegui("southwest")
plot(t_tot,X,'LineWidth',2,'DisplayName','x')
hold on
plot(t_tot,Y,'LineWidth',2,'DisplayName','y')
title("x, y over time")
xlabel('Time [sec]')
ylabel('coordinations[m]')
legend('Location','best')
grid on
saveas(gcf,"../img/xy.png")
%% plot theta
figure(4)
movegui("southeast")
plot(t_tot,theta1,'LineWidth',2,'DisplayName','\theta_1')
hold on
plot(t_tot,theta2,'LineWidth',2,'DisplayName','\theta_2')
title("\theta_1, \theta_2 over time")
xlabel('Time [sec]')
ylabel('\theta [rad]')
legend('Location','best')
grid on
saveas(gcf,"../img/thetas.png")
%% calculate lambda
for i = 2:length(t_event_change)
    idx0 = find(t_tot==t_event_change(i-1));
    idx1 = find(t_tot==t_event_change(i)) -1 ;
    if event_order(i) == ["Flied"]
        for j = idx0:idx1
            lam_n_plot(j) = 0;
            lam_t_plot(j) = 0;
        end
    elseif event_order(i) == ["Sticked"]
        for j = idx0:idx1
            [lam_n,lam_t,lam_n_slip] = lam_calc(X_tot(j,:),tau_calc(t_tot(j)));
            lam_n_plot(j) = lam_n;
            lam_t_plot(j) = lam_t;

        end
    elseif event_order(i) == ["Slipped"]
        for j = idx0:idx1
            [lam_n,lam_t,lam_n_slip] = lam_calc(X_tot(j,:),tau_calc(t_tot(j)));
                lam_n_plot(j) = lam_n_slip;
                lam_t_plot(j) = lam_t;
            if lam_n_slip * mu < abs(lam_t)
                lam_n_plot(j) = lam_n_slip;
                lam_t_plot(j) = 0.05*lam_t;
            end
        end
    else
        error()
    end
end
%% lamn
figure(5)
movegui('north'	)
plot(t_tot(1:length(lam_n_plot)),lam_n_plot,'r','LineWidth',2)
yline(0,'--','LineWidth',2)
title("\lambda_n over time")
xlabel('Time [sec]')
ylabel('\lambda_n [N]')
for i = 1:length(t_event_change)
    idx = find(t_tot==t_event_change(i));
    xline(t_tot(idx),'b--','LineWidth',2)
    if i ~= length(t_event_change)
        txt  = num2str(event_order(i+1));
        if txt == "Sticked"
            txt = "Stick";
        end
        if txt == "Slipped"
            txt = "Slip";
        end
        if txt == "Flied"
            txt = "Fly";
        end
        text(t_tot(idx),6-i,txt)
    end
end
grid on
saveas(gcf,"../img/lambda_n.png")
%% lam t /lam n
figure(6)
movegui('south')
for i = 1:length(t_tot)-1
    ratio(i) = lam_t_plot(i)/lam_n_plot(i);
end
plot(t_tot(1:end-1),ratio,'r','LineWidth',2)
for i = 1:length(t_event_change)
    idx = find(t_tot==t_event_change(i));
    xline(t_tot(idx),'b--','LineWidth',2)
    if i ~= length(t_event_change)
        txt  = num2str(event_order(i+1));
        if txt == "Sticked"
            txt = "Stick";
        end
        if txt == "Slipped"
            txt = "Slip";
        end
        if txt == "Flied"
            txt = "Fly";
        end
        text(t_tot(idx),1-0.3*i,txt)
    end
end
yline(mu,'k--','LineWidth',1)
yline(-mu,'k--','LineWidth',1)
title("\lambda_t / \lambda_n over time")
xlabel('Time [sec]')
ylabel('\lambda_t / \lambda_n')
% ylim([-mu*1.05 mu*1.05])
grid on
saveas(gcf,"../img/lambda_ratio.png")
%% lamt
figure(7)
movegui('center')
plot(t_tot(1:length(lam_t_plot)),lam_t_plot,'r','LineWidth',2)
yline(0,'--','LineWidth',2)
title("\lambda_t over time")
xlabel('Time [sec]')
ylabel('\lambda_t [N]')
for i = 1:length(t_event_change)
    idx = find(t_tot==t_event_change(i));
    xline(t_tot(idx),'b--','LineWidth',2)
    if i ~= length(t_event_change)
        txt  = num2str(event_order(i+1));
        if txt == "Sticked"
            txt = "Stick";
        end
        if txt == "Slipped"
            txt = "Slip";
        end
        if txt == "Flied"
            txt = "Fly";
        end
        text(t_tot(idx),6-i,txt)
    end
end
grid on
function [t_tot,X_tot,ie_slip,ie_stick,ie_fly,t_event_change,event_order] = ground_simulation(t_tot,X_tot,ie_slip,ie_stick,ie_fly,t_event_change,event_order)
% simulation loop when the robot hasn't left the ground
global dt t_f
while true
    % Event stick
    if ie_slip==2
        tspan = t_tot(end):dt:t_f;
        X0 = X_tot(end,:);
        op_stick = odeset('RelTol',1e-10,'AbsTol',1e-10,'Events',@events_stick);
        [t_stick,X_stick,te_stick,Xe_stick,ie_stick] = ode45(@(t,X) sys_stick(t,X),tspan,X0,op_stick);
        t_tot = [t_tot;t_stick(2:end)];
        X_tot = [X_tot;X_stick(2:end,:)];
        t_event_change = [t_event_change te_stick(end)];
        event_order = [event_order;'Sticked'];
        disp("Sticked: "+num2str(t_tot(end)))
        if ie_stick(end) == 3
            break
%             error("point R touched the ground while sticking before flying\n Run animation_regarless_of_error.m to see the animation")
        end
        if ie_stick(end) == 4
            break
%             error("point Q touched the ground while sticking before flying\n Run animation_regarless_of_error.m to see the animation")
        end
        if ie_stick(end) == 5
            break
%             error("point Q touched the ground while sticking before flying\n Run animation_regarless_of_error.m to see the animation")
        end
    end
    
    % Event slip
    if  ie_stick(end) == 1 || ie_stick(end) == 2
        tspan = t_tot(end):dt:t_f;
        X0 = X_tot(end,:);
        op_slip = odeset('RelTol',1e-6,'AbsTol',1e-6,'Events',@events_slip);
        [t_slip,X_slip,te_slip,Xe_slip,ie_slip] = ode45(@(t,X) sys_slip(t,X),tspan,X0,op_slip);
        t_event_change = [t_event_change te_slip(end)];
        event_order = [event_order;'Slipped'];
        disp("Slipped: "+num2str(t_tot(end)))
        t_tot = [t_tot;t_slip(2:end)];
        X_tot = [X_tot;X_slip(2:end,:)];
        if ie_slip(end) == 1
            break
%             error("point R touched the ground while slipping before flying\n Run animation_regarless_of_error.m to see the animation")
        end
        if ie_slip(end) == 3
            break
%             error("point R touched the ground while slipping before flying\n Run animation_regarless_of_error.m to see the animation")
        end
        if ie_slip(end) == 4
            break
%             error("point Q touched the ground while slipping before flying\n Run animation_regarless_of_error.m to see the animation")
        end
    end
end

end


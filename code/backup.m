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
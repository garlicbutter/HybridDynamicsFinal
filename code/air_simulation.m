function [t_tot,X_tot,ie_fly,t_event_change,event_order] = air_simulation(t_tot,X_tot,t_event_change,event_order)
% Event fly
% global d_start
% d_start=(X_tot(end,1)); % for distance measurement later on.
global dt t_f
tspan = t_tot(end):dt:t_f;
X0 = X_tot(end,:);
op_fly = odeset('RelTol',1e-12,'AbsTol',1e-12,'Events',@events_fly);
[t_fly,X_fly,te_fly,Xe_fly,ie_fly] = ode45(@(t,X) sys_fly(t,X),tspan,X0,op_fly);
event_order = [event_order;'Flied'];
t_event_change = [t_event_change te_fly(end)];
t_tot = [t_tot;t_fly(2:end)];
X_tot = [X_tot;X_fly(2:end,:)];
% if ie_fly(end) == 2
%     error("point R landed on the ground first\n Run animation_regarless_of_error.m to see the animation")
% end
% if ie_fly(end) == 3
%     error("point Q landed on the ground first\n Run animation_regarless_of_error.m to see the animation")
% end
disp("flied:   "+num2str(t_tot(end)))% if ie_fly(end) == 4
%     error("line PR breached the angle constraint at time: "+ num2str(te_fly(end)))
% end
end


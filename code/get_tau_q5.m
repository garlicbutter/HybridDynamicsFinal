function tau = get_tau_q5(X)

theta1 = X(3);
theta2 = X(4);
%%%%%%%%%% q5 only %%%%%%%%%%%%%%
global theta12dd_desired
theta12 = theta1+theta2;
if theta12 > 100
    theta12dd_desired = -0.3;
elseif theta12 < 50
    theta12dd_desired = 0.3;
else
    theta12dd_desired = 0;
end
tau=tau_q5(X);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

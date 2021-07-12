function tau=calc_tau(t,X,i)
%%taking off torque
if i==1
    T=0.01;
        if t<T
            tau=10;% -6,-6.7
        else 
            tau=tau_step(X);
            tau=-3.688;
        end
        
end

%%flying torque
% if i==2
%     tau=-10*exp(-60.5*t);
% end
if i==2
    tau=-10*exp(-95*t);

end
%%landing torque

if i==3
    tau=0.49;
end

end
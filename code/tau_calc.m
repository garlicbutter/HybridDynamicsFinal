function tau = tau_calc(t)
global time0 time1 time2 time3
time0 = 0;
time1 = 0.02;
time2 = 0.12;
time3 = 0.22;

global f1 f2 f3 f4
f1 = @(t) 10-1500*(t-0.04)^2;
f2 = @(t) -1; 
f3 = @(t) 0.5;   
f4 = @(t) 1; 

if time0 <= t && t<time1
    t = t - time0;
    tau = f1(t);
elseif time1 <= t && t<time2
    t = t - time1;
    tau = f2(t);
elseif time2 <= t && t<time3
    t = t-time2;
    tau = f3(t);
elseif time3 <= t
    t = t-time3;
    tau = f4(t);
end

end
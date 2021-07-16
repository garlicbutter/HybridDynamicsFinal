function tau = tau_calc(t)

global time0 time1 time2 time3
time0 = 0;
time1 = 0.05;
time2 = 0.10;
time3 = 0.30;

global f1 f2 f3 f4
f1 = @(t) 7;
f2 = @(t) -5+20*t; 
f3 = @(t) -0.5;  
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
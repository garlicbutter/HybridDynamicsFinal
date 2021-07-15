function tau = tau_calc(t)

time0 = 0;
time1 = 0.02;
time2 = 0.06;
time3 = 0.9;

f1 = @(t) 2; 
f2 = @(t) -3; 
f3 = @(t) 0;  
f4 = @(t) 0; 

if time0 <= t && t<time1
    tau = f1(t);
elseif time1 <= t && t<time2
    tau = f2(t);
elseif time2 <= t && t<time3
    tau = f3(t);
elseif time3 <= t
    tau = f4(t);
end

end
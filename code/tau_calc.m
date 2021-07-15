function tau = tau_calc(t)

time0 = 0;
time1 = 0.05;
time2 = 0.1;
time3 = 0.15;

f1 = @(t) -4;
f2 = @(t) 8; 
f3 = @(t) 4;  
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
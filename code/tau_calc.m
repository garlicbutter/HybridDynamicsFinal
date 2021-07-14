function tau = tau_calc(t,X)
global sigma m g L
global t0 t1 t2 t3 t4 state

x = X(1);
y = X(2);
theta_1 = X(3);
theta_2 = X(4);
xd = X(5);
yd = X(6);
theta_1d = X(7);
theta_2d = X(8);

r_P=[x;y];
r_Q=[x+2*L*cos(theta1);y+2*L*sin(theta1)];
r_R = r_Q + [2*l*cos(theta1+theta2),2*l*sin(theta1+theta2)];


angle = atan(abs(r_R(2)-r_P(2))/abs(r_R(1)-r_Pz(1)));
if angle < 30/180*pi
    good = 0;
end

if  state ==1
    texp1 = t - t0;
    tau = -1.2*exp(-1*texp1);
    t1 = t;
    if theta_2 <=-20*pi/180 % use this criteria to find suitable t1
        state = 2;
    end
elseif  state ==2 
    texp2 = t - t1;
    tau = 2*exp(-1*(texp2));
    t2 = t;
    if theta_1<=100*pi/180 % use this criteria to find suitable t2
        state =3;
    end
elseif state == 3
    texp3 = t - t2;
    tau =  -3*exp(-1*(texp3));
    t3 = t;
    if t>= t2 + (t2-t1)*(1/2)% use this criteria to find suitable t3
        state = 4;
    end
elseif state == 4
    texp4 = t-t3;
    tau = -0.05;%  avoid slip   0.5*exp(-30*(texp4));%-1*exp(-80*texp4); 
    t4 = t; 
end

angle = 90 - angle/pi*180;
end
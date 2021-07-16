clc;clear all;close all;

L=0.15;
x=0;
y=0;

phi = deg2rad(10):0.01:deg2rad(100);
rCG = [0,0;];
phi_plot = [0;];
for i = 1:length(phi)
    % initial condition
    theta1_0 = deg2rad(40) + phi(i);
    theta2_0 = -2 * phi(i);
    rQ0 = [2*L*cos(theta1_0);2*L*sin(theta1_0)];
    rR0 = rQ0 + [2*L*cos(theta1_0+theta2_0);2*L*sin(theta1_0+theta2_0)];
    if rQ0(2)>rR0(2)
        continue
    end
    r1c = [x+L*cos(theta1_0),y+L*sin(theta1_0)];
    r2c = [x+2*L*cos(theta1_0)+L*cos(theta1_0+theta2_0), y+2*L*sin(theta1_0)+L*sin(theta1_0+theta2_0)];
    rCG = [rCG; (r1c+r2c)/2];
    phi_plot = [phi_plot;phi(i)];
end
figure(1)
title("Center of Gravity , x")
xlabel("phi")
movegui("west")
h = animatedline;
for  k = 1:length(rCG)
    addpoints(h,rad2deg(phi_plot(k)),rCG(k,1))
    drawnow
end

figure(2)
title("Center of Gravity , y")
xlabel("phi")
movegui("east")
h = animatedline;
for  k = 1:length(rCG)
    addpoints(h,rad2deg(phi_plot(k)),rCG(k,2))
    drawnow
end
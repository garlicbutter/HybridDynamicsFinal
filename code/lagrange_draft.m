clc;clear;close all;
syms x y theta1 theta2
syms xd yd theta1d theta2d
syms m L g mu Ic

r1c = [x+L*cos(theta1);y+L*sin(theta1)];
r2c = [x+2*L*cos(theta1)+L*cos(theta1+theta2); y+2*L*sin(theta1)+L*sin(theta1+theta2)];
rCG = (r1c+r2c)/2;
v1c = [xd-L*theta1d*sin(theta1);
       yd+L*theta1d*cos(theta1)];
v2c = [xd-2*L*theta1d*sin(theta1)-L*(theta1d+theta2d)*sin(theta1+theta2);
       yd+2*L*theta1d*cos(theta1)+L*(theta1d+theta2d)*cos(theta1+theta2)];
T = m/2 * (v1c.'*v1c + v2c.'*v2c) + Ic * theta1d^2 + Ic*(theta1d+theta2d)^2;
V = 2*m*g*rCG(2):
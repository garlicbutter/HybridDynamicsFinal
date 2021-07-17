clc;clear;close all;

th1 = 0:0.5:180;
th2 = 0:0.5:180;
[TH1,TH2] = meshgrid(th1,th2);
heat = 3*cos(deg2rad(TH1)+deg2rad(TH2))/40 + 9*cos(deg2rad(TH1))/40 ;
TH1 = reshape(TH1,[361*361,1]);
TH2 = reshape(TH2,[361*361,1]);
heat = reshape(heat,[361*361,1]);


figure(1)
hold on
title("Optimizing the initial condition")
xlim([0 180])
ylim([0 180])
scatter(TH1,TH2,[],heat)
colormap(gca,'winter')
patch([30 0 0 150 180], [0 60 180 30*sqrt(3)/(sqrt(3)-1) 0], 'blue', 'edgecolor', 'black','FaceAlpha',0)
xlabel("\theta_1 (deg)")
ylabel("\theta_2 (deg)")

hold off
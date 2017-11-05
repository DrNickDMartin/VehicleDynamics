%%

clear; close all; clc

load('silverstone.mat')

t = linspace(0,dt*numel(s),numel(s))';

n = numel(s);
v = gradient(s,t);

ft = fittype( 'smoothingspline' );
opts = fitoptions( 'Method', 'SmoothingSpline' );
opts.SmoothingParam = 0.015;
vs = fit(s,v,ft,opts);
vs = vs(s);

ds = gradient(s);
omega = vs./R;
beta = cumtrapz(s,omega);
b0=60;
x = cumsum(ds.*cos(deg2rad(beta+b0)));
y = cumsum(ds.*sin(deg2rad(beta+b0)));

figure
plot(s,v,s,vs,'.-')
xlabel('Distance (m)')
ylabel('V (m/s)')

figure
plot(s,beta,'.-')
xlabel('Distance (m)')
ylabel('Heading (deg)')

figure
plot(x,y)
axis equal






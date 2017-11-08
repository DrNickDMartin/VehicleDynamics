% Brush tyre model
clear; clc; close all

a = 0.2;
cp = 250000;
cpx = cp;
cpy = cp;
mux = 1;
muy = 1;
Fz = 5000;

alpha = deg2rad(0);
s = 0.15;

% Compute the slips
sx = s;
sy = tan(alpha);

% Start by plotting the load distrinution over the contact patch
x = linspace(-a,a,500);
dFax = cpx*sx*(a-x);

qz = ((3*Fz)/(4*a))*(1-(x./a).^2);
spx = (3*Fz*mux)/(2*a*a*cpx);

psi = sqrt((sx/spx)^2+(sy/spx)^2);
xs = (2*psi-1)*a;

f = figure;
ax = axes('Parent',f);
area(x(x<=xs),qz(x<=xs))
hold(ax,'on')
area(x(x>=xs),dFax(x>=xs))
plot(x,qz,'k--','linewidth',2)
plot([xs,xs],[0,cpx*sx*(a-xs)],'k','linewidth',2)
box(ax,'on');
set(ax,'YTick',zeros(1,0),'XTick',zeros(1,0));

% [s,alpha] = ndgrid(linspace(-0.8,0.8,50),[0.1,0.075,0.05,0.025,-0.025]);
[alpha,s] = ndgrid(linspace(-25,25,50),[0.1,0.075,0.05,0.025,0,-0.025,-0.05,-0.075,-0.1]);
[Fx,Fy] = brush_model(s,deg2rad(alpha),Fz,a,cpx,cpy,mux,muy); 

figure
plot(alpha,Fy)



% Tyre plotting
clear; clc; close all

%%

[settings,variable,corr,model] = TreadSimParams();
s = linspace(-0.75,0.75,100)';
Fx = zeros(numel(s),1);
Fz = 500;
variable.Fz = Fz;

params = gettyrepar();
for i = 1:numel(s)
    variable.kappa = s(i);
    [Fx(i,1),~,~,~] = TreadSim(settings,model,variable,corr);
end

fs = 20;
figure()
plot(s,Fx/Fz,'linewidth',2)
ax = gca;
ax.FontSize = fs;
grid on
ylim([-1.2, 1.2])
xlabel('s','fontsize',fs)
ylabel('F_x/F_z','fontsize',fs)
text(0.35,1.1,'Sliding','fontsize',fs)
text(-0.65,-1.1,'Sliding','fontsize',fs)
text(0.2,0,'Accelerating','fontsize',fs)
text(-0.5,0,'Braking','fontsize',fs)

%%






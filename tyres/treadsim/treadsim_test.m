% treadsim test
clear; clc; close all

[settings,variable,corr,model] = TreadSimParams();

alpha = linspace(-0.5,0.5,20)';
Fy = zeros(numel(alpha),1);

variable.Fz = 5000;

params = gettyrepar();
for i = 1:numel(alpha)
    variable.kappa = alpha(i);
    [Fy(i,1),~,~,~] = TreadSim(settings,model,variable,corr);
end

plot(alpha,Fx,'')
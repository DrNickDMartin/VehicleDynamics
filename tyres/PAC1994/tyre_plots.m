clear; close all; clc

s = linspace(-0.75,0.75,500)';
Fx = zeros(numel(s),1);
Fz = 1000;

for i = 1:numel(s)
    [Fx(i,1),~,~] = magic_model(0,s(i),Fz,0);
end

fs = 18;
figure;
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
text(-0.75,0,'Braking','fontsize',fs)

%%

a = linspace(0,12,100)';
fz = [4000,5000,6000,7000];
Fy = zeros(numel(a),numel(fz));
Mz = zeros(numel(a),numel(fz));

for j = 1:numel(fz)
    for i = 1:numel(a)
        [~,Fy(i,j),Mz(i,j)] = magic_model(a(i),0,fz(j),0);
    end
end

figure;
fs = 18;
plot(a,Fy(:,1)*1e-3,...
    a,Fy(:,2)*1e-3,...
    a,Fy(:,3)*1e-3,...
    a,Fy(:,4)*1e-3,'linewidth',2)
ax = gca;
ax.FontSize = fs;
legend('F_z=4kN','F_z=5kN','F_z=6kN','F_z=7kN','Location','northwest')
grid on
xlabel('\alpha (deg)','fontsize',fs)
ylabel('F_y (kN)','fontsize',fs)

figure;
fs = 18;
plot(a,Fy(:,1)/fz(1),...
    a,Fy(:,2)/fz(2),...
    a,Fy(:,3)/fz(3),...
    a,Fy(:,4)/fz(4),'linewidth',2)
ax = gca;
ax.FontSize = fs;
legend('F_z=4kN','F_z=5kN','F_z=6kN','F_z=7kN','Location','southeast')
grid on
xlabel('\alpha (deg)','fontsize',fs)
ylabel('F_y/F_z','fontsize',fs)

figure;
fs = 18;
plot(Mz(:,1),Fy(:,1)*1e-3,...
    Mz(:,2),Fy(:,2)*1e-3,...
    Mz(:,3),Fy(:,3)*1e-3,...
    Mz(:,4),Fy(:,4)*1e-3,'linewidth',2)
ax = gca;
ax.FontSize = fs;
xlim([0,150])
legend('F_z=4kN','F_z=5kN','F_z=6kN','F_z=7kN','Location','southeast')
grid on
xlabel('M_z (Nm)','fontsize',fs)
ylabel('F_y (kN)','fontsize',fs)

%%

g = linspace(0,12,100)';
fz = 4000;
Fy = zeros(numel(g),numel(fz));

for i = 1:numel(g)
    [~,Fy(i,1),~] = magic_model(0,0,fz,g(i));
end

fs = 18;
figure;
plot(g,Fy*1e-3,'linewidth',2)
ax = gca;
ax.FontSize = fs;
grid on
xlabel('\gamma (deg)','fontsize',fs)
ylabel('F_y (kN)','fontsize',fs)

%%

a = linspace(0,12,100)';
g = [-15,-7,0,7,15];
fz = 4000;
Fy = zeros(numel(a),numel(g));
Mz = zeros(numel(a),numel(g));

for j = 1:numel(g)
    for i = 1:numel(a)
        [~,Fy(i,j),Mz(i,j)] = magic_model(a(i),0,fz,0);
    end
end

fs = 18;
figure;
plot(a,Fy(:,1)*1e-3,...
    a,Fy(:,1)*1e-3+0.5,...
    a,Fy(:,1)*1e-3+1,...
    a,Fy(:,1)*1e-3-0.5,...
    a,Fy(:,1)*1e-3-1,...
    'linewidth',2)
ax = gca;
ax.FontSize = fs;
grid on
xlabel('\alpha (deg)','fontsize',fs)
ylabel('F_y (kN)','fontsize',fs)
legend('\gamma=0\circ','\gamma=5\circ',...
    '\gamma=10\circ','\gamma=-5\circ','\gamma=-10\circ','Location','southeast')

%%

s = linspace(-0.75,0.75,100)';
a = [1,2,4,8,12];
fz = 4000;
Fy = zeros(numel(s),numel(a));
Fx = zeros(numel(s),numel(a));
Mz = zeros(numel(s),numel(a));

for j = 1:numel(a)
    for i = 1:numel(s)
        [Fx(i,j),Fy(i,j),Mz(i,j)] = magic_model(a(j),s(i),fz,0);
    end
end

fs = 18;
figure;
plot(s,Fx(:,1)/fz,...
    s,Fx(:,2)/fz,...
    s,Fx(:,3)/fz,...
    s,Fx(:,4)/fz,...
    s,Fx(:,5)/fz,...
    'linewidth',2)
ax = gca;
ax.FontSize = fs;
xlim([-0.75,0.75])
grid on
xlabel('s','fontsize',fs)
ylabel('\mu_x','fontsize',fs)
legend('\alpha=1\circ','\alpha=2\circ',...
    '\alpha=4\circ','\alpha=8\circ','\alpha=12\circ','Location','southeast')

figure;
plot(s,Fy(:,1)/fz,...
    s,Fy(:,2)/fz,...
    s,Fy(:,3)/fz,...
    s,Fy(:,4)/fz,...
    s,Fy(:,5)/fz,...
    'linewidth',2)
ax = gca;
ax.FontSize = fs;
xlim([-0.75,0.75])
grid on
xlabel('s','fontsize',fs)
ylabel('F_y/F_z','fontsize',fs)
legend('\alpha=1\circ','\alpha=2\circ',...
    '\alpha=4\circ','\alpha=8\circ','\alpha=12\circ','Location','northeast')

%%

a = linspace(-20,20,100)';
s = [0,0.1,0.2,0.5,0.8];
fz = 4000;
Fy = zeros(numel(s),numel(a));
Fx = zeros(numel(s),numel(a));
Mz = zeros(numel(s),numel(a));

for j = 1:numel(s)
    for i = 1:numel(a)
        [Fx(i,j),Fy(i,j),Mz(i,j)] = magic_model(a(i),s(j),fz,0);
    end
end

figure;
plot(a,Fx(:,1)/fz,...
    a,Fx(:,2)/fz,...
    a,Fx(:,3)/fz,...
    a,Fx(:,4)/fz,...
    a,Fx(:,5)/fz,...
    'linewidth',2)
ax = gca;
ax.FontSize = fs;
grid on
xlabel('\alpha (deg)','fontsize',fs)
ylabel('\mu_x','fontsize',fs)
legend('s=0','s=0.1','s=0.2','s=0.5','s=0.8','Location','south')

figure;
plot(a,Fy(:,1)/fz,...
    a,Fy(:,2)/fz,...
    a,Fy(:,3)/fz,...
    a,Fy(:,4)/fz,...
    a,Fy(:,5)/fz,...
    'linewidth',2)
ax = gca;
ax.FontSize = fs;
grid on
xlabel('\alpha (deg)','fontsize',fs)
ylabel('\mu_y','fontsize',fs)
legend('s=0','s=0.1','s=0.2','s=0.5','s=0.8','Location','north')

%%

a = linspace(-20,20,20)';
s = linspace(-2,2,100)';
fz = 4000;
Fy = zeros(numel(a),numel(s));
Fx = zeros(numel(a),numel(s));
Mz = zeros(numel(a),numel(s));

for j = 1:numel(s)
    for i = 1:numel(a)
        [Fx(i,j),Fy(i,j),Mz(i,j)] = magic_model(a(i),s(j),fz,0);
    end
end

figure;
plot(Fx,Fy,'.')
ax = gca;
ax.FontSize = fs;
grid on
xlabel('F_x (N)','fontsize',fs)
ylabel('F_y (N)','fontsize',fs)
% legend('s=0','s=0.1','s=0.2','s=0.5','s=0.8','Location','north')
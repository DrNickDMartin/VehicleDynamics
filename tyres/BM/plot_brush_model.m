% Brush tyre model

a = 0.3;
cpy = 100000;
mu = 1;
Fz = 1000;
Ty = (2*cpy*a*a)/(3*mu*Fz);

alpha_SL = atan(1/Ty);

alpha = linspace(-12,12,100);
sigy = tan(deg2rad(alpha));

tsigy = Ty*sigy;

Fy = 3*mu*Fz*tsigy.*(1-abs(tsigy)+(1/3)*(tsigy.^2));
FySL = mu*Fz*sign(alpha);

Fy(abs(deg2rad(alpha))>=alpha_SL) = FySL(abs(deg2rad(alpha))>=alpha_SL);

plot(sigy,Fy/(Fz*mu))
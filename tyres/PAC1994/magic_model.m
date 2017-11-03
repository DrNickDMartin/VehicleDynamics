function [Fx,Fy,Mz] = magic_model(alpha,s,Fz,gamma,aParams,bParams,cParams)
%MAGIC_MODEL Implementation of the '94 Pacejka tyre model
%
%   OUTPUT:
%       - Fx                   = longitudinal force        [N]
%       - Fy                   = lateral force             [N]
%       - Mz                   = aligning torque           [Nm]
%
% Author: N.Martin - 02.11.17
%
% Example usage: [Fx,Fy,Mz] = magic_model(alpha,s,aParams,bParams)
%                [Fx,Fy,Mz] = magic_model(alpha,s)

if (nargin==4)
    [aParams,bParams,cParams] = magic_params();
end

s = s*100;
Fz = Fz*1e-3;

%% Longitudinal Force
% Coefficient	Name                Parameters      Formula
% C             Shape factor        b0              C = b0
% D             Peak factor         b1, b2          D = Fz * (b1*Fz + b2)
% BCD           Stiffness           b3, b4, b5      BCD = (b3*Fz2 + b4*Fz) * e(-b5*Fz)
% B             Stiffness factor	BCD, C, D       B = BCD / (C*D)
% E             Curvature factor	b6, b7, b8, b13	E = (b6*Fz2 + b7*Fz + B8) * (1 – b13*sign(slip+H))
% H             Horizontal shift	b9, b10	H = b9* Fz + b10
% V             Vertical shift      b11, b12        V = b11*Fz + b12
% Bx1           (composite)                         Bx1 = B * (slip + H)

C = bParams.b0;
Dx = Fz*(bParams.b1*Fz + bParams.b2);
BCD = (bParams.b3*Fz^2 + bParams.b4*Fz)*exp(-bParams.b5*Fz);
B = BCD / (C*Dx);
Hx = bParams.b9*Fz + bParams.b10;
E = (bParams.b6*Fz^2 + bParams.b7*Fz + bParams.b8)*(1 - bParams.b13*sign(s+Hx));
Vx = bParams.b11*Fz + bParams.b12;
Bx1 = B*(s + Hx);

Fx = Dx*sin(C*atan(Bx1 - E * (Bx1 - atan(Bx1)))) + Vx;


%% Lateral Force
% Coefficient	Name                Parameters          Formula
% C             Shape factor        a0                  C = a0
% D             Peak factor         a1, a2, a15         D = Fz * (a1*Fz + a2) * (1 – a15*?2)
% BCD           Stiffness           a3, a4, a5          BCD = a3 * sin(atan(Fz / a4) * 2) * (1 – a5*|?|)
% B             Stiffness factor	BCD, C, D           B = BCD / (C*D)
% E             Curvature factor	a6, a7, a16, a17	E = (a6*Fz + a7) * (1 – (a16*? + a17)*sign(slip+H))
% H             Horizontal shift	a8, a9, a10         H = a8*Fz + a9 + a10*?
% V             Vertical shift      a11, a12, a13, a14	V = a11*Fz + a12 + (a13*Fz + a14)*?*Fz
% Bx1           (composite)                             Bx1 = B * (slip + H)

C = aParams.a0;
Dy = Fz * (aParams.a1*Fz + aParams.a2) * (1 - aParams.a15*gamma^2);
BCD = aParams.a3 * sin(atan(Fz / aParams.a4) * 2) * (1 - aParams.a5*abs(gamma));
B = BCD / (C*Dy);
Hy = aParams.a8*Fz + aParams.a9 + aParams.a10*gamma;
E = (aParams.a6*Fz + aParams.a7) * (1 - (aParams.a16*gamma + aParams.a17)*sign(alpha+Hy));
Vy = aParams.a11*Fz + aParams.a12 + (aParams.a13*Fz + aParams.a14)*gamma*Fz;
Bx1 = B*(alpha + Hy);

Fy = Dy*sin(C*atan(Bx1 - E*(Bx1 - atan(Bx1)))) + Vy;

%% Aligning Moment

C = cParams.c0;
D = (cParams.c1*Fz^2 + cParams.c2*Fz)*(1-cParams.c18*gamma);
BCD = (cParams.c3*Fz^2 + cParams.c4*Fz)*(1-(cParams.c6*abs(gamma)))*exp(-cParams.c5*Fz);
B = BCD/(C*D);
H = cParams.c11*Fz+cParams.c12+cParams.c13*gamma;
V = cParams.c14*Fz + cParams.c15 + (cParams.c16*Fz*Fz+cParams.c17*Fz)*gamma;
X1 = (deg2rad(alpha) + H);
E = (((cParams.c7*Fz^2) + (cParams.c8*Fz) + cParams.c9)*...
    (1-(((cParams.c19*gamma)+cParams.c20)*sign(X1))))/...
    (1-cParams.c10*abs(gamma));

Mz = (D*sin(C*atan(B*X1-E*(B*X1-atan(B*X1)))))+V;

%% Combined Forces

alpha = deg2rad(alpha);
s = s/100;

ss = s + bParams.b9*Fz + bParams.b10;
alphas = alpha + aParams.a8*Fz + aParams.a9 + aParams.a10*gamma;

SAG = sin(alphas);
beta = acos(abs(ss)/sqrt(ss^2+SAG^2));

muxact = (Fx-Hx)/Fz;
muyact = (Fy-Hy)/Fz;
muxmax = Dx/Fz;
muymax = Dy/Fz;

mux = 1/sqrt((1/muxact)^2 + (tan(beta)/muymax)^2);
muy = tan(beta)/sqrt((1/muxmax)^2 + (tan(beta)/muyact)^2);

ax = Mz/Fy;

Fx = (mux/muxact)*(Fx+Vx);
Fy = (muy/muyact)*(Fy+Vy);
Mz = Fy*ax;

if (s<0)
    Fx = -Fx;
end

if (alpha<0)
    Fy = -Fy;
end



function [Fx,MF_macro_par]= MF1996_LongForce_calc(MF1996_par,Kx,NormalLoad,NominalLoad)
% Pcx1 is MF_par(1)
% Pdx1 is MF_par(2)
% Pdx2 is MF_par(3)
% Pex1 is MF_par(4)
% Pex2 is MF_par(5)
% Pex3 is MF_par(6)
% Pex4 is MF_par(7)
% Pkx1 is MF_par(8)
% Pkx2 is MF_par(9)
% Pkx3 is MF_par(10)
% Phx1 is MF_par(11)
% Phx2 is MF_par(12)
% Pvx1 is MF_par(13)
% Pvx2 is MF_par(14)

dfz=(NormalLoad-NominalLoad)/NominalLoad;

 Cx=MF1996_par(1);

muex=(MF1996_par(2)+MF1996_par(3)*dfz)*1;
 Dx=muex*NormalLoad;

Kxk=NormalLoad*(MF1996_par(8)+MF1996_par(9)*dfz)*exp(-MF1996_par(10)*dfz)*1;
 Bx=Kxk/( Cx* Dx);

Svx=NormalLoad*(MF1996_par(13)+MF1996_par(14)*dfz)*1;

 Ex_half=(MF1996_par(4)+MF1996_par(5)*dfz+MF1996_par(6)*dfz^2);
F=@(Kx) Dx*(sin( Cx*atan( Bx*Kx-...
    (Ex_half*(1-MF1996_par(7)*sign(Kx))*1)*...
    ( Bx*Kx-atan( Bx*Kx)))))+Svx;

Fx=arrayfun(@(x,y) F(x),Kx);%,'UniformOutput',false);

MF_macro_par.Ex=  abs(Ex_half*(1-MF1996_par(7)*sign(Kx))*1);
MF_macro_par.Dx=  Dx;
MF_macro_par.Bx=  Bx;
MF_macro_par.Cx=  Cx;
end
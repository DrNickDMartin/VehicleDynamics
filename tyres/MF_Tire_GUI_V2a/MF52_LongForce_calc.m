function [Fx,MF_macro_par]= MF52_LongForce_calc(MF52_par,Kx,NormalLoad)
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

Cx=MF52_par(1);
 
muex=MF52_par(2)+MF52_par(3)*(NormalLoad/1000);
Dx=muex*(NormalLoad/1000);
 
Kxk=(NormalLoad/1000)*(MF52_par(8)+MF52_par(9)*(NormalLoad/1000))*exp(-MF52_par(10)*(NormalLoad/1000))*1;
Bx=Kxk/(Cx*Dx);
 
Svx=(NormalLoad/1000)*(MF52_par(13)+MF52_par(14)*(NormalLoad/1000))*1; 
         
Ex_half=(MF52_par(4)+MF52_par(5)*(NormalLoad/1000)+MF52_par(6)*(NormalLoad^2/1000000));
F=@(Kx)Dx*(sin(Cx*atan(Bx*Kx-...
    (Ex_half*(1-MF52_par(7)*sign(Kx))*1)*...
    (Bx*Kx-atan(Bx*Kx)))))+Svx;

Fx=arrayfun(@(x) F(x),Kx);%,'UniformOutput',false);

MF_macro_par.Ex= abs(Ex_half*(1-MF52_par(7)*sign(Kx(1)))*1);
MF_macro_par.Dx= Dx;
MF_macro_par.Bx= Bx;
MF_macro_par.Cx= Cx;

end
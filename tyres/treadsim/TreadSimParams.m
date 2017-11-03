function [settings,variable,corr,model] = TreadSimParams()
%TREADSIMPARAMS Returns a default set of tyre parameters for TradSim
%   Author: N.Martin - 25.10.17

%**  model settings
model.nrow=3;         % number of rows (1 or 2 or 3)
model.n=20;           % number of bristle elements in longitudinal direction
model.iitend=25;       % =5....25 (number of iterations depends on carcass compliance)

%**  tyre parameters
settings.re = 0.3;         % effective rolling radius [m]
settings.a = 0.1;          % half contact length [m]
settings.b = 0.08;         % half contact width [m]
settings.brow = 0.05;      % half effective contact width [m]
settings.mu0 = 1;          % friction coefficient [-]
settings.amu = 0.0;        % speed dependency coefficient for mu [s/m] ( mu=mu0/(1+amu*Vbi) );      0.03
settings.CFkappaFz = 15;   % long. slip stiffness over Fz [-]
settings.alphadegply =0;  % ply-steer equivalent slip angle [deg]
settings.gammadegcon =0;  % conicity equivalent camber angle [deg]

% stiffnesses of tyre carcass at contact patch at base of tread elements (as if measured on bare tyre)
settings.cyaw = 6000;      % [Nm/rad]
settings.cbend = 4000;      % [mN]
settings.clat = 100000;    % [N/m]       suggested:  clat=Fz/(0.15*a)

%**  correction parameters
corr.epsyprime=0.0;  % reduction factor for moment (Mzprime) arm of Fx causing yaw distortion (slope);
corr.epsyrgamma=4;   % moment (Mz) arm for Fx due to sideways rolling caused by camber = ygamroll=epsyrgamma*gamma*b; if abs(ygamroll)>b: ygamroll=b*sign(gamma)
corr.epsyFy=0.0;     % reduction factor moment(Mz)arm for Fx due to sideways rolling caused by Fy and the counter effect of longitudinal deflection total moment {Mz) arm= ymeff= ym0+ydefl(1-epsyFy)+ygamroll
corr.epsdrgam=0.0;   % coefficient for reduced change eff. rolling radius left/right caused by camber delta_re_Right=~ -(1-epsdrgam)*gamma*brow; suggestion: epsdrgam (=epsxgamma)=epsgamma
corr.epsgamma=0.0;   % reduced camber curvature coefficient (will be >0) due to distorsion (=epsygamma) resulting camber contactline curvature (at mu=0) 1/Rgamma=(1/re)*(1-epsgamma)*sin(gamma)
corr.y0=0.00;        % initial lateral off-set (vo) , if rigid: Mz=Mz-c*Fx*Fy-y0*Fx  (0.005)

%**  motion parameters (overruled if chosen as changed parameter or as running variable)
variable.Fz = 3000;        % normal load [N]
variable.Vc = 5;          % speed of contact centre [m/s]
variable.alphadeg = 0;     % [deg]    (slip angle)
variable.gammadeg = 0;     % [deg]    (camber angle)
variable.R = 10000000;     % [m]      (aphit=a/R;   non-dimensional turnslip) 10000000
variable.kappa = 0;        % [-]      (long. slip ratio)


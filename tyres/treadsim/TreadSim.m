function [Fx,Fy,Mz,t] = TreadSim(settings,model,variable,corr)
%TREADSIM TreadSim tyre model
%
%   OUTPUT:
%       - Fx                   = longitudinal force        [N]
%       - Fy                   = lateral force             [N]
%       - Mz                   = aligning torque           [Nm]
%       - t                    = pneumatic trail           [m]
%
% Author: N.Martin - 25.10.17 (adapted from: TreadSim.m by H.B. Pacejka)
%
% Example usage: [Fx,Fy,Mz,t] = TreadSim(settings,model,variable,corr)

%**  model settings
nrow = model.nrow;
n = model.n;

%**  tyre parameters
Fz = variable.Fz;                       % normal load [N]
re = settings.re;                       % effective rolling radius [m]
a = settings.a;                         % half contact length [m]
b = settings.b;                         % half contact width [m]
brow = settings.brow;                   % half effective contact width [m]
mu0 = settings.mu0;                     % friction coefficient [-]
amu = settings.amu;                     % speed dependency coefficient for mu [s/m] ( mu=mu0/(1+amu*Vbi) );      0.03
CFkappaFz = settings.CFkappaFz;      	% long. slip stiffness over Fz [-]
alphadegply = settings.alphadegply;    	% ply-steer equivalent slip angle [deg]
gammadegcon = settings.gammadegcon;    	% conicity equivalent camber angle [deg]

% stiffnesses of tyre carcass at contact patch at base of tread elements (as if measured on bare tyre)
cyaw = settings.cyaw;      % [Nm/rad]
cbend = settings.cbend;      % [mN]
clat = settings.clat;    % [N/m]       suggested:  clat=Fz/(0.15*a)

%**  correction parameters
epsyprime = corr.epsyprime;
epsyrgamma = corr.epsyrgamma; 
epsyFy = corr.epsyFy;
epsdrgam = corr.epsdrgam;
epsgamma = corr.epsgamma;
y0 = corr.y0;

%**  motion parameters (overruled if chosen as changed parameter or as running variable)
Vc = variable.Vc;                   % speed of contact centre [m/s]
alphadeg = variable.alphadeg;       % [deg]    (slip angle)
gammadeg = variable.gammadeg;       % [deg]    (camber angle)
R = variable.R;                     % [m]      (aphit=a/R;   non-dimensional turnslip)
kappa = variable.kappa;             % [-]      (long. slip ratio)

%% End of parameter settings

if nrow==1
    brow=0;
end
iitend=5;

CFkappa=CFkappaFz*Fz; %[N/-] from this: cp=(1/(nrow*2*a*a))*CFkappa;
% cornering stiffness coeff. CFalpha/Fz [-] is calculated if alpharuns=1 for last parameter case

% resulting stiffness of tread elements, per row, per unit of circumfernce
cp=(1/(nrow*2*a*a))*CFkappa;
a2=a*a; a3=a2*a;

aphit=a/R; 
alpha=alphadeg*pi/180;
gamma=(gammadeg+gammadegcon)*pi/180;
singam=sin(gamma);
cs0=alphadegply*pi/180;             % initial belt slope due to ply-steer
cc0=(1/re)*(1-epsgamma)*singam;     % initial belt lateral curvature due to camber and conicity
ym0=-0.5*cc0*a2;                    % initial belt lateral position at contact centre resulting from camber at mu=0
ygamroll=epsyrgamma*singam*b;       % moment arm of Fx due to sideways rolling at camber

if abs(ygamroll)>b
    ygamroll=b*sign(gamma);
end

cs=cs0;
cc=cc0;
ym=ym0;
Fy=0;
Mzprime=0;
R=a/(aphit+0.0001);

%%  begin carcass deflection iteration, iit-loop
for iit=1:iitend
    slope=Mzprime/cyaw;
    cs=cs0+slope;                       % belt slope at contact centre w.r.t. wheel plane
    curve=Fy/cbend;
    cc=cc0-curve;                       % belt lateral curvature in contact zone
    ydefl= Fy/clat;
    ym=ym0+ydefl;                       % belt lateral position at contact centre w.r.t. wheel plane
    yFyroll=-epsyFy*ydefl;
    ymeff=ym+ygamroll+yFyroll;          % effective moment (Mz) arm for Fx
    
    % **  begin left (iLR=1) and right row (iLR=2) loop (if one row: nrow=1)
    for iLR=1:nrow
        if nrow==1
            ibLR=0; bLR=0;
        end
        if nrow==2
            ibLR=(2*iLR-3); bLR=ibLR*brow;
        end
        if nrow==3
            ibLR=(iLR-2); bLR=ibLR*brow;  % left: bLR=-brow,  middle: bLR=0,  right: bLR=+brow
        end
        
        psidot= -Vc/R;
        
        Vcx=Vc*cos(alpha);
        Vsx= -Vcx*kappa;
        Vsy= -Vcx*tan(alpha);
        Vr=Vcx-Vsx;
        omega=Vr/re;
        VcxLR=Vcx-bLR*psidot;
        VsxLR=Vsx-bLR*psidot+bLR*omega*(1-epsdrgam)*singam;
        VsyLR=Vsy;
        VrLR=Vr;
        
        deltat=2*a/(n*VrLR);
        deltax=2*a/n;
        xi=a;
        x = zeros(n+1,1);
        x(1)=a;
        ei=0; exi=0; eyi=0; Fxim1=0; Fyim1=0; Mzim1=0;
        sliding=0;
        
        % **  begin i-loop: passage through contact length
        for  i=2:n+1
            eim1=ei; exim1=exi; eyim1=eyi;
            xi=xi-deltax; xi2=xi*xi;
            x(i)=xi;
            dybdximean=cs+cc*(xi+0.5*deltax);
            ybi=ym +cs*xi+0.5*cc*xi*xi+bLR;
            ybieff=ymeff+cs*xi+0.5*cc*xi*xi+bLR;
            Vbxi=VsxLR;
            Vbyimean=VsyLR + (xi+0.5*deltax)*psidot - VrLR*dybdximean;
            Vbi=sqrt(Vbxi*Vbxi+Vbyimean*Vbyimean); % belt point velocity
            mu=mu0/(1+amu*Vbi);
            pzi=0.75*Fz*(a2-xi2)/(a3*nrow); % vertical pressure distribution (qz)
            deltasxi=deltat*Vbxi;
            deltasyi=deltat*Vbyimean;
            
            if sliding>0           % element is sliding
                ei=mu*pzi/cp;
                if i==2
                    eim1=0.00001;
                    exim1=-eim1*Vbxi/Vbi;
                    eyim1=-eim1*Vbyimean/Vbi;
                end
                gi=0.5*eim1*((exim1-deltasxi)*(exim1-deltasxi)+(eyim1-deltasyi)*(eyim1-deltasyi)-ei*ei)/....
                    (exim1*(exim1-deltasxi)+eyim1*(eyim1-deltasyi));
                exi=(1-gi/eim1)*exim1-deltasxi;
                eyi=(1-gi/eim1)*eyim1-deltasyi;
                ein=sqrt(exi*exi+eyi*eyi);
                exi=(ei/ein)*exi;                   % correction
                eyi=(ei/ein)*eyi;                   % correction
                pxi=(exi/ei)*mu*pzi;
                pyi=(eyi/ei)*mu*pzi;
                if gi<0                % element starts to adhere to the road
                    sliding=0;
                    exi=-deltasxi+exim1;
                    eyi=-deltasyi+eyim1;
                    ei=sqrt(exi*exi+eyi*eyi);
                    pii=cp*ei;
                    pxi=cp*exi;
                    pyi=cp*eyi;
                    if pii>mu*pzi
                        pxi=(exi/ei)*mu*pzi;
                        pyi=(eyi/ei)*mu*pzi;
                        sliding=1;
                    end
                end
            else                     % element is adhering to the road
                exi=-deltasxi+exim1;
                eyi=-deltasyi+eyim1;
                ei=sqrt(exi*exi+eyi*eyi);
                pii=cp*ei;
                pxi=cp*exi;
                pyi=cp*eyi;
                if pii>mu*pzi           % element starts to slide
                    sliding=1;
                    if i==2
                        eim1=0.00001;
                        exim1=-eim1*Vbxi/Vbi;
                        eyim1=-eim1*Vbyimean/Vbi;
                    end
                    ei=mu*pzi/cp;
                    gi=0.5*eim1*((exim1-deltasxi)*(exim1-deltasxi)+(eyim1-deltasyi)*(eyim1-deltasyi)-ei*ei)/....
                        (exim1*(exim1-deltasxi)+eyim1*(eyim1-deltasyi));
                    exi=(1-gi/eim1)*exim1-deltasxi;
                    eyi=(1-gi/eim1)*eyim1-deltasyi;
                    ein=sqrt(exi*exi+eyi*eyi);
                    exi=(ei/ein)*exi;                  % correction
                    eyi=(ei/ein)*eyi;                  % correction
                    pxi=(exi/ei)*mu*pzi;
                    pyi=(eyi/ei)*mu*pzi;
                end
            end
            
            pii=sqrt(pxi*pxi+pyi*pyi);
            
            Fxi=Fxim1+pxi*2*a/n;
            Fyi=Fyim1+pyi*2*a/n;
            Mzi=Mzim1+(xi*pyi -ybieff*pxi)*2*a/n;
            Fxim1=Fxi;
            Fyim1=Fyi;
            Mzim1=Mzi;
            
           
        end  % **  end i-loop (passage through contact length)
        
        % **  forces and moment
        if ibLR==-1
            FxL=Fxi; FyL=Fyi; MzL=Mzi;
        else
            if ibLR==0
                FxM=Fxi; FyM=Fyi; MzM=Mzi;
            else
                FxR=Fxi; FyR=Fyi; MzR=Mzi;
            end
        end
        
    end  % **  end iLR-loop (one, two or three rows of elements)
    
    if nrow==1
        Fx=FxM;
        Fy=FyM;
        Mz=MzM;
    else
        if nrow==2
            Fx=FxL+FxR;
            Fy=FyL+FyR;
            Mz=MzL+MzR;
        else
            Fx=FxL+FxR+FxM;
            Fy=FyL+FyR+FyM;
            Mz=MzL+MzR+MzM;
        end
    end
    
    Mzprime=Mz+Fx*ymeff*epsyprime;      % for torsion (slope) calculation
    
end  % **  end iit-loop (carcass deflection iteration)

Mz=Mz-y0*Fx;

t=-Mz/Fy;    % pneumatic trail


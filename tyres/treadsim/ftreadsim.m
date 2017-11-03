

%% Load tyre parameters
p0 = 2e5;                   % nominal tyre pressure
mu0 = tyrepar(1);           % static friction [-]
amu = tyrepar(2);           % speed dependant coefficient for mu0 [s/m]
dmudp = tyrepar(3);         % pressure dependency coefficient for mu [-]
cpx = tyrepar(4);           % tread stiffness in x [N/m^2]
cpy = tyrepar(5);           % tread stiffness in y [N/m^2]
c1 = tyrepar(6);            % pressure distribution shape coefficient increasing
c2 = tyrepar(7);            % pressure distribution shape coefficient decreasing
Cvert = tyrepar(8);         % vertical stiffness coefficient
Cyaw = tyrepar(9);          % yaw stiffness
EI = tyrepar(10);           % belt bend stiffness
Clat = tyrepar(11);         % belt lateral stiffness
alphaply = tyrepar(12);     % ply-steer equivalent slip angle
gammadegcon = tyrepar(13);  % equivalent camber angle [deg] - 0
epsdrgam = tyrepar(14);     % camber efficiency radius change - 0.8

Clatbeam = Clat*(0.4 + 0.6*Pinfl/p0);
Cvert = (Cvert + Cvert*0.1/150*(Vc - 60/3.6)*3.6)*Pinfl;
defl = Fz/Cvert;
a = r0*0.4*(defl/r0 + 2.25*sqrt(defl/r0));
cir = r0*2*pi;
dx1 = 2*a/nbristle;
dx2 = (cir - dx1*(nbristle-1))/(nbeamelem-(nbristle-1));
dy1 = 2*b/nrow;

% aphit = a/R;
b0 = b- 0.5*dy1;
alpha = (alphadeg +  alphaply)*pi/180;
gamma = (gammadeg + gammadegcon)*pi/180;
singam = sin(gamma);

Fx = 0;
Fy = 0;
Mz = 0;

%% Create stiffness matrix

EI = EI*(0.4 + 0.6*Pinfl/p0);
Kc = zeros(2*nbeamelem,2*nbeamelem);
dx1p3 = dx1^3;
dx2p3 = dx2^3;

F1y1 = EI/dx1p3*[12,6*dx1;6*dx1,4*dx1^2];
F1y2 = EI/dx1p3*[-12,6*dx1;-6*dx1,2*dx1^2];
F2y1 = EI/dx1p3*[-12,-6*dx1;6*dx1,2*dx1^2];
F2y2 = EI/dx1p3*[12,-6*dx1;-6*dx1,4*dx1^2];

F1y1d12 = EI/dx2p3*[12,6*dx2;6*dx2,4*dx2^2];
F1y2d12 = EI/dx2p3*[-12,6*dx2;-6*dx2,2*dx2^2];
F2y1d12 = EI/dx2p3*[-12,-6*dx2;6*dx2,2*dx2^2];
F2y2d12 = EI/dx2p3*[12,-6*dx2;-6*dx2,4*dx2^2];

for i=1:nbeamelem-1
    n = i*2-1;
    
    if i <= nbristle-1
        Kc(n,n) = Kc(n,n) + Clatbeam*dx1/2;
        Kc(n+2,n+2) = Kc(n+2,n+2) + Clatbeam*dx1/2;
        Kc(n+1,n+1) = Kc(n+1,n+1) + Cyaw*dx1/2;
        Kc(n+3,n+3) = Kc(n+3,n+3) + Cyaw*dx1/2;
        
        Kc(n,n) = Kc(n,n) + F1y1(1,1);
        Kc(n+1,n+1) = Kc(n+1,n+1) + F1y1(2,2);
        Kc(n+1,n) = Kc(n+1,n) + F1y1(2,1);
        Kc(n,n+1) = Kc(n,n+1) + F1y1(2,1);
        
        Kc(n+2,n+2) = Kc(n+2,n+2) + F2y2(1,1); 
        Kc(n+3,n+3) = Kc(n+3,n+3) + F2y2(2,2);
        Kc(n+3,n+2) = Kc(n+3,n+2) + F2y2(2,1);
        Kc(n+2,n+3) = Kc(n+2,n+3) + F2y2(1,2);
        
        Kc(n,n+2) = Kc(n,n+2) + F1y2(1,1);
        Kc(n+1,n+3) = Kc(n+1,n+3) + F1y2(2,2);
        Kc(n+1,n+2) = Kc(n+1,n+2) + F1y2(2,1);
        Kc(n,n+3) = Kc(n,n+3) + F1y2(1,2);
        
        Kc(n+2,n) = Kc(n+2,n) + F2y1(1,1);
        Kc(n+3,n+1) = Kc(n+3,n+1) + F2y1(2,2);
        Kc(n+3,n) = Kc(n+3,n) + F2y1(2,1);
        Kc(n+2,n+1) = Kc(n+2,n+1) + F2y1(1,2);
        
    else
        Kc(n,n) = Kc(n,n) + Clatbeam*dx2/2;
        Kc(n+2,n+2) = Kc(n+2,n+2) + Clatbeam*dx2/2;
        Kc(n+1,n+1) = Kc(n+1,n+1) + Cyaw*dx2/2;
        Kc(n+3,n+3) = Kc(n+3,n+3) + Cyaw*dx2/2;
        
        Kc(n,n) = Kc(n,n) + F1y1d12(1,1);
        Kc(n+1,n+1) = Kc(n+1,n+1) + F1y1d12(2,2);
        Kc(n+1,n) = Kc(n+1,n) + F1y1d12(2,1);
        Kc(n,n+1) = Kc(n,n+1) + F1y1d12(2,1);
        
        Kc(n+2,n+2) = Kc(n+2,n+2) + F2y2d12(1,1); 
        Kc(n+3,n+3) = Kc(n+3,n+3) + F2y2d12(2,2);
        Kc(n+3,n+2) = Kc(n+3,n+2) + F2y2d12(2,1);
        Kc(n+2,n+3) = Kc(n+2,n+3) + F2y2d12(1,2);
        
        Kc(n,n+2) = Kc(n,n+2) + F1y2d12(1,1);
        Kc(n+1,n+3) = Kc(n+1,n+3) + F1y2d12(2,2);
        Kc(n+1,n+2) = Kc(n+1,n+2) + F1y2d12(2,1);
        Kc(n,n+3) = Kc(n,n+3) + F1y2d12(1,2);
        
        Kc(n+2,n) = Kc(n+2,n) + F2y1d12(1,1);
        Kc(n+3,n+1) = Kc(n+3,n+1) + F2y1d12(2,2);
        Kc(n+3,n) = Kc(n+3,n) + F2y1d12(2,1);
        Kc(n+2,n+1) = Kc(n+2,n+1) + F2y1d12(1,2);
        
    end
    
    if i == (nbeamelem-1)
        i = nbeamelem; %#ok<*FXSET>
        n = (i-1)*2 +1;
        
        Kc(n:n+1,n:n+1) = Kc(n:n+1,n:n+1) + F1y1d12;
        Kc(1:2,1:2) = Kc(1:2,1:2) + F2y2d12;
        Kc(n:n+1,1:2) = Kc(n:n+1,1:2) + F2y2d12;
        Kc(1:2,n:n+1) = Kc(1:2,n:n+1) + F2y2d12;
        
        Kc(n,n) = Kc(n,n) + Clatbeam*dx2/2;
        Kc(1,1) = Kc(1,1) + Clatbeam*dx2/2;
        Kc(n+1,n+1) = Kc(n+1,n+1) + Cyaw*dx2/2;
        Kc(2,2) = Kc(2,2) + Cyaw*dx2/2;
    end
end

%% Carcass iteration loop:

s1 = zeros(2*nbeamelem,1);
FM = zeros(2*nbeamelem,1);
% iKc = inv(Kc);
iit = 1;
Fybeam = zeros(nbristle,1);

while iit <= iitend
    if iit > 1
        for i=1:length(Fybeam)
            n = (i-1)*2 + 1;
            FM(n,1) = Fybeam(i,1);
        end
        s1 = Kc\FM; %iKc*FM
    end
    Fybeam = zeros(nbristle,1);
    Fxrowi = 0;
    Fyrowi = 0;
    Mzrowi = 0;
    
    for iLR = 1:nrow
        
        bLR = b0 - (iLR-1)*dy1;
        psidot = -Vc/R;
        Vcx = Vc*cos(alpha);
        Vsx = -Vcx*kappa;
        Vsy = Vcx*tan(alpha);
        Vr = Vcx-Vsx;
        omega = Vr/r0;
%         VcxLR = Vcx - bLR*psidot;
        VsxLR = Vsx - bLR*psidot + bLR*omega*(epsdrgam-1)*singam;
        VsyLR = Vsy;
        deltat = 2*a/(nbristle*Vr);
        xi = a + 0.5*dx1;
        x(1) = xi;
        exi = 0;
        eyi = 0;
        Fxim1 = 0;
        Fyim1 = 0;
        Mzim1 = 0;
        px(1) = 0;
        py(1) = 0;
        pz(1) = 0;
        p(1) = 0;
        
        for i=2:nbristle+1
            
            exim1 = exi;
            eyim1 = eyi;
            xi = xi-dx1;
            x(i) = xi; %#ok<AGROW>
            dybdximean = -sin(s1((i-1)*2,1)) + singam*cos(xi/r0+pi/2);
            ybi = s1(2*i-3,1) + bLR + r0*singam*sin(xi/r0+pi/2);
            Vbxi = VsxLR;
            Vbyimean = VsyLR + (xi+0.5*dx1)*psidot - Vr*dybdximean;
            nVbi = sqrt(Vbxi^2+Vbyimean^2);
            a2 = 2*a;
            Pmax = Fz/(2*b*(a2 - a2*c1/2 - a2*c2/3));
            x1 = xi;
            x1 = -(x1 - a);
            if x1 <= c1*a2
                pz = Pmax*(x1/a2/c1);
            elseif (x1 <= (a2 - a2*c2)) && (x1 > c1*a2)
                pz = Pmax;
            else
                pz = Pmax*(1-(x1-a2+a2*c2)^2/(a2*c2)^2);
            end
            p = pz*(1-bLR*alpha);
            
            dsix = deltat*Vbxi;
            dsiy = deltat*Vbyimean;
            mu = (p/p0)^-dmudp*(mu0/(1+amu*nVbi));
            
            %Element deformation
            exizs = exim1 - dsix;
            eyizs = eyim1 - dsiy;
            eizs = sqrt((exizs)^2 + (eyizs)^2);
            deff = sqrt((exizs*cpx)^2 + (eyizs*cpy)^2);
            
            % check for sliding
            if deff <= mu*p
                exi = exizs;
                eyi = eyizs;
                px = cpx*exi;
                py = cpy*eyi;
                slidex = 0;
                slidey = 0;
            else
                cor = (mu*p)/deff;
                fx = cpx*exizs/deff;
                fy = cpy*eyizs/deff;
                
                % correction for relatively large sliding
                if cor < 0.66
                    fx = fx*(cor)/0.66 + (0.66 - cor)/0.66*exizs/eizs;
                    fy = fy*(cor)/0.66 + (0.66 - cor)/0.66*eyizs/eizs;
                end
                
                abca = (cpx*fx)^2 + (cpy*fy)^2;
                abcb = 2*cpx^2*exizs*fx + 2*cpy^2*eyizs*fy;
                abcc = (cpx*exizs)^2 + (cpy*eyizs)^2 - (mu*p)^2;
                sd = sqrt(abcb^2 - 4*abca*abcc);
                oplos = (-abcb + sd)/(2*abca);
                
                slidex = real(oplos*fx);
                slidey = real(oplos*fy);
                
                exi = exizs + slidex;
                eyi = eyizs + slidey;
                
                px = cpx*exi;
                py = cpy*eyi;
            end
            
            slidedist = sqrt(slidex^2 + slidey^2);
            Vem1 = slidedist/deltat;
            Fybeam(i-1,1) = Fybeam(i-1,1) + py*dx1*dy1;
            Fxi = Fxim1 + px*dx1*dy1;
            Fyi = Fyim1 + py*dx1*dy1;
            Mzi = Mzim1 + (xi*py - ybi*px)*dx1*dy1;
            
            Fxim1 = Fxi;
            Fyim1 = Fyi;
            Mzim1 = Mzi;
        end
        
        Fxrowi = Fxrowi + Fxi;
        Fyrowi = Fyrowi + Fyi;
        Mzrowi = Mzrowi + Mzi;
    end
   
    endwhile = ((Fx+Fy+Mz)-(Fxrowi+Fyrowi+Mzrowi))/(Fxrowi+Fyrowi+Mzrowi);
    
    Fx = Fxrowi;
    Fy = Fyrowi;
    Mz = Mzrowi;
    
    iit = iit+1;
    
    if abs(endwhile) < 1e-3 && iit < iitend
        if picture == 1
            iit = iitend;
        else
            iit = iitend+1;
        end
    end
end

disp(['Total number of iterations = ',num2str(iit)])
disp(['Sliding velocity = ',num2str(Vem1)])

t = -Mz/Fy;

% if picture == 1
%     figure(1)
%     clf
%     hold on
%     for i = 1:nbristle
%         for j = 1:nrow
%             plot([Px(j,i,1),Px(j,i,1)+Px(j,i,2)],[Py(j,i,1),Py(j,i,1)+Py(j,i,2)],...
%                 Px(j,i,1)+Px(j,i,2),Py(j,i,1)+Py(j,i,2),'kx')
%             plot(Px(j,i,1),Py(j,i,1),'ro')
%             plot([0, Vc*cos(alpha)/300],[0,Vc*sin(alpha/300)],'g')
%         end
%     end
%     plot([-a a a -a -a],[-b -b b b -b])
%     xlabel('Tyre length (a)')
%     ylabel('Tyre width (b)')
%     hold off
%     axis([-1.2*a 1.2*a -1.2*b, 1.2*b]);
% end


end


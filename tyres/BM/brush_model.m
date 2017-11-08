function [Fx,Fy] = brush_model(s,alpha,Fz,a,cpx,cpy,mux,muy)
%BRUSH_MODEL This is a function to compute the longitudinal and lateral
%forces on a tyre given the slip ratio (s), slip angle (alhpha in degrees),
%normal load (Fz) and tyre properties
%   N.D Martin - 01/11/17

% Compute the dimensionless slips
sx = s./(1+s);
sy = tan(deg2rad(alpha))./(1+s);

% Calculate the sliding ratio
psix = (2*cpx*a*a)/(3*mux*Fz);
psiy = (2*cpy*a*a)/(3*muy*Fz);

% Calculate the combined slip
sc = sqrt(sx.^2+sy.^2);
sc_sl_x = 1/psix;
sc_sl_y = 1/psiy;

% Force from the x component
Fxx = mux*Fz*(3*psix*sc - 3*(psix*sc).^2 + (psix*sc).^3);
Fxx(sc>=sc_sl_x) = mux*Fz;

% Force from the y component
Fyy = muy*Fz*(3*psiy*sc - 3*(psiy*sc).^2 + (psiy*sc).^3);
Fyy(sc>=sc_sl_y) = muy*Fz;

% Inividual force components
Fx = (Fxx./sc).*sx;
Fy = (Fyy./sc).*sy;

end


% % The model only works with postive slips, so save the signs
% ssx = sign(sx);
% ssy = sign(sy);
% sx = abs(sx);
% sy = abs(sy);
% 
% % Calculate the slip limits and the ellipse
% spx = (3*Fz*mux)/(2*a*a*cpx);
% spy = (3*Fz*muy)/(2*a*a*cpy);
% psi = sqrt((sx/spx).^2+(sy/spy).^2);
% 
% % Above 1, the model revers to pure slipping (psi = 1)
% psi(psi>=1) = 1;
% 
% % Force from adhesion
% Fax = -2*a*a*cpx*sx.*(1-psi).^2;
% Fay = -2*a*a*cpy*sy.*(1-psi).^2;
% 
% % Calculate the contribution of normal slip load
% Fsz = Fz*psi.*psi.*(3-2*psi);
% 
% % Calculate the sliding load
% if (psi<1)
%     Fsx = -cos(ar).*mux.*Fsz;
%     Fsy = -sin(ar).*muy.*Fsz;
% else
%     Fsx = -mux.*Fsz;
%     Fsy = -muy.*Fsz;
% end
% 
% % Calculate the total load components
% Fx = (Fax+Fsx).*ssx;
% Fy = (Fay+Fsy).*ssy;
% 
% % Output some additional quantities
% COMPS.Fax = Fax;
% COMPS.Fay = Fay;
% COMPS.Fsx = Fsx;
% COMPS.Fsy = Fsy;
% COMPS.psi = psi;

function [params] = tyre_0001()
% PAC2002 Tyre Parameter Model
%
% Tire 235/60R16

%---------------------------------------------------------dimensions
params.UNLOADED_RADIUS = 0.344; %Free tyre radius
params.WIDTH = 0.235; %Nominal section width of the
params.ASPECT_RATIO = 0.6; %Nominal aspect ratio
params.RIM_RADIUS = 0.19; %Nominal rim radius
params.RIM_WIDTH = 0.16; %Rim width
%----------------------------------------------------------parameter
params.VERTICAL_STIFFNESS = 2.1e+005; %Tyre vertical stiffness
params.VERTICAL_DAMPING = 50; %Tyre vertical damping
params.BREFF = 8.4; %Low load stiffness e.r.r.
params.DREFF = 0.27; %Peak value of e.r.r.
params.FREFF = 0.07; %High load stiffness e.r.r.
params.FNOMIN = 4850; %Nominal wheel load
%-------------------------------------------------------------scaling
params.LFZO = 1; %Scale factor of nominal (rated) load
params.LCX = 1; %Scale factor of Fx shape factor
params.LMUX = 1; %Scale factor of Fx peak friction coefficient
params.LEX = 1; %Scale factor of Fx curvature factor
params.LKX = 1; %Scale factor of Fx slip stiffness
params.LHX = 1; %Scale factor of Fx horizontal shift
params.LVX = 1; %Scale factor of Fx vertical shift
params.LGAX = 1; %Scale factor of camber for Fx
params.LCY = 1; %Scale factor of Fy shape factor
params.LMUY = 1; %Scale factor of Fy peak friction coefficient
params.LEY = 1; %Scale factor of Fy curvature factor
params.LKY = 1; %Scale factor of Fy cornering stiffness
params.LHY = 1; %Scale factor of Fy horizontal shift
params.LVY = 1; %Scale factor of Fy vertical shift
params.LGAY = 1; %Scale factor of camber for Fy
params.LTR = 1; %Scale factor of Peak of pneumatic trail
params.LRES = 1; %Scale factor for offset of residual torque
params.LGAZ = 1; %Scale factor of camber for Mz
params.LXAL = 1; %Scale factor of alpha influence on Fx
params.LYKA = 1; %Scale factor of alpha influence on Fx
params.LVYKA = 1; %Scale factor of kappa induced Fy
params.LS = 1; %Scale factor of Moment arm of Fx
params.LSGKP = 1; %Scale factor of Relaxation length of Fx
params.LSGAL = 1; %Scale factor of Relaxation length of Fy
params.LGYR = 1; %Scale factor of gyroscopic torque
params.LMX = 1; %Scale factor of overturning couple
params.LVMX = 1; %Scale factor of Mx vertical shift
params.LMY = 1; %Scale factor of rolling resistance torque
%-------------------------------------------------------longitudinal
params.PCX1 = 1.6411; %Shape factor Cfx for longitudinal force
params.PDX1 = 1.1739; %Longitudinal friction Mux at Fznom
params.PDX2 = -0.16395; %Variation of friction Mux with load
params.PDX3 = 0; %Variation of friction Mux with camber
params.PEX1 = 0.46403; %Longitudinal curvature Efx at Fznom
params.PEX2 = 0.25022; %Variation of curvature Efx with load
params.PEX3 = 0.067842; %Variation of curvature Efx with load squared
params.PEX4 = -3.7604e-005; %Factor in curvature Efx while driving
params.PKX1 = 22.303; %Longitudinal slip stiffness Kfx/Fz at Fznom
params.PKX2 = 0.48896; %Variation of slip stiffness Kfx/Fz with load
params.PKX3 = 0.21253; %Exponent in slip stiffness Kfx/Fz with load
params.PHX1 = 0.0012297; %Horizontal shift Shx at Fznom
params.PHX2 = 0.0004318; %Variation of shift Shx with load
params.PVX1 = -8.8098e-006; %Vertical shift Svx/Fz at Fznom
params.PVX2 = 1.862e-005; %Variation of shift Svx/Fz with load
params.RBX1 = 13.276; %Slope factor for combined slip Fx reduction
params.RBX2 = -13.778; %Variation of slope Fx reduction with kappa
params.RCX1 = 1.2568; %Shape factor for combined slip Fx reduction
params.REX1 = 0.65225; %Curvature factor of combined Fx
params.REX2 = -0.24948; %Curvature factor of combined Fx with load
params.RHX1 = 0.0050722; %Shift factor for combined slip Fx reduction
params.PTX1 = 2.3657; %Relaxation length SigKap0/Fz at Fznom
params.PTX2 = 1.4112; %Variation of SigKap0/Fz with load
params.PTX3 = 0.56626; %Variation of SigKap0/Fz with exponent of load
%--------------------------------------------------------overturning
params.QSX1 = 0; %Lateral force induced overturning moment
params.QSX2 = 0; %Camber induced overturning couple
params.QSX3 = 0; %Fy induced overturning couple 
%------------------------------------------------------------lateral
params.PCY1 = 1.3507; %Shape factor Cfy for lateral forces
params.PDY1 = 1.0489; %Lateral friction Muy
params.PDY2 = -0.18033; %Variation of friction Muy with load
params.PDY3 = -2.8821; %Variation of friction Muy with squared camber
params.PEY1 = -0.0074722; %Lateral curvature Efy at Fznom
params.PEY2 = -0.0063208; %Variation of curvature Efy with load
params.PEY3 = -9.9935; %Zero order camber dependency of curvature Efy
params.PEY4 = -760.14; %Variation of curvature Efy with camber
params.PKY1 = -21.92; %Maximum value of stiffness Kfy/Fznom
params.PKY2 = 2.0012; %Load at which Kfy reaches maximum value
params.PKY3 = -0.024778; %Variation of Kfy/Fznom with camber
params.PHY1 = 0.0026747; %Horizontal shift Shy at Fznom
params.PHY2 = 8.9094e-005; %Variation of shift Shy with load
params.PHY3 = 0.031415; %Variation of shift Shy with camber
params.PVY1 = 0.037318; %Vertical shift in Svy/Fz at Fznom
params.PVY2 = -0.010049; %Variation of shift Svy/Fz with load
params.PVY3 = -0.32931; %Variation of shift Svy/Fz with camber
params.PVY4 = -0.69553; %Variation of shift Svy/Fz with camber and load
params.RBY1 = 7.1433; %Slope factor for combined Fy reduction
params.RBY2 = 9.1916; %Variation of slope Fy reduction with alpha
params.RBY3 = -0.027856; %Shift term for alpha in slope Fy reduction
params.RCY1 = 1.0719; %Shape factor for combined Fy reduction
params.REY1 = -0.27572; %Curvature factor of combined Fy
params.REY2 = 0.32802; %Curvature factor of combined Fy with load
params.RHY1 = 5.7448e-006; %Shift factor for combined Fy reduction
params.RHY2 = -3.1368e-005; %Shift factor for combined Fy reduction with load
params.RVY1 = -0.027825; %Kappa induced side force Svyk/Muy*Fz at Fznom
params.RVY2 = 0.053604; %Variation of Svyk/Muy*Fz with load
params.RVY3 = -0.27568; %Variation of Svyk/Muy*Fz with camber
params.RVY4 = 12.12; %Variation of Svyk/Muy*Fz with alpha
params.RVY5 = 1.9; %Variation of Svyk/Muy*Fz with kappa
params.RVY6 = -10.704; %Variation of Svyk/Muy*Fz with atan(kappa)
params.PTY1 = 2.1439; %Peak value of relaxation length SigAlp0/R0
params.PTY2 = 1.9829; %Value of Fz/Fznom where SigAlp0 is extreme
%-------------------------------------------------rolling resistance
params.QSY1 = 0.01; %Rolling resistance torque coefficient
params.QSY2 = 0; %Rolling resistance torque depending on Fx
params.QSY3 = 0; %Rolling resistance torque depending on speed
params.QSY4 = 0; %Rolling resistance torque depending on speed ^4
%-----------------------------------------------------------aligning
params.QBZ1 = 10.904; %Trail slope factor for trail Bpt at Fznom
params.QBZ2 = -1.8412; %Variation of slope Bpt with load
params.QBZ3 = -0.52041; %Variation of slope Bpt with load squared
params.QBZ4 = 0.039211; %Variation of slope Bpt with camber
params.QBZ5 = 0.41511; %Variation of slope Bpt with absolute camber
params.QBZ9 = 8.9846; %Slope factor Br of residual torque Mzr
params.QBZ10 = 0; %Slope factor Br of residual torque Mzr
params.QCZ1 = 1.2136; %Shape factor Cpt for pneumatic trail
params.QDZ1 = 0.093509; %Peak trail Dpt" = Dpt*(Fz/Fznom*R0)
params.QDZ2 = -0.0092183; %Variation of peak Dpt" with load
params.QDZ3 = -0.057061; %Variation of peak Dpt" with camber
params.QDZ4 = 0.73954; %Variation of peak Dpt" with camber squared
params.QDZ6 = -0.0067783; %Peak residual torque Dmr" = Dmr/(Fz*R0)
params.QDZ7 = 0.0052254; %Variation of peak factor Dmr" with load
params.QDZ8 = -0.18175; %Variation of peak factor Dmr" with camber
params.QDZ9 = 0.029952; %Variation of peak factor Dmr" with camber and load 

params.QEZ1 = -1.5697; %Trail curvature Ept at Fznom
params.QEZ2 = 0.33394; %Variation of curvature Ept with load
params.QEZ3 = 0; %Variation of curvature Ept with load squared
params.QEZ4 = 0.26711; %Variation of curvature Ept with sign of Alpha-t
params.QEZ5 = -3.594; %Variation of Ept with camber and sign Alpha-t
params.QHZ1 = 0.0047326; %Trail horizontal shift Sht at Fznom
params.QHZ2 = 0.0026687; %Variation of shift Sht with load
params.QHZ3 = 0.11998; %Variation of shift Sht with camber
params.QHZ4 = 0.059083; %Variation of shift Sht with camber and load
params.SSZ1 = 0.033372; %Nominal value of s/R0: effect of Fx on Mz
params.SSZ2 = 0.0043624; %Variation of distance s/R0 with Fy/Fznom
params.SSZ3 = 0.56742; %Variation of distance s/R0 with camber
params.SSZ4 = -0.24116; %Variation of distance s/R0 with load and camber
params.QTZ1 = 0.2; %Gyration torque constant
params.MBELT = 5.4; %Belt mass of the wheel
%-----------------------------------------------turn-slip parameters
params.PECP1 = 0.7; %Camber stiffness reduction factor
params.PECP2 = 0.0; %Camber stiffness reduction factor with load
params.PDXP1 = 0.4; %Peak Fx reduction due to spin
params.PDXP2 = 0.0; %Peak Fx reduction due to spin with load
params.PDXP3 = 0.0; %Peak Fx reduction due to spin with longitudinal slip
params.PDYP1 = 0.4; %Peak Fy reduction due to spin
params.PDYP2 = 0.0; %Peak Fy reduction due to spin with load
params.PDYP3 = 0.0; %Peak Fy reduction due to spin with lateral slip
params.PDYP4 = 0.0; %Peak Fy reduction with square root of spin
params.PKYP1 = 1.0; %Cornering stiffness reduction due to spin
params.PHYP1 = 1.0; %Fy lateral shift shape factor
params.PHYP2 = 0.15; %Maximum Fy lateral shift
params.PHYP3 = 0.0; %Maximum Fy lateral shift with load
params.PHYP4 = -4.0; %Fy lateral shift curvature factor
params.QDTP1 = 10.0; %Pneumatic trail reduction factor
params.QBRP1 = 0.1; %Residual torque reduction factor with lateral slip
params.QCRP1 = 0.2; %Turning moment at constant turning with zero speed
params.QCRP2 = 0.1; %Turning moment at 90 deg lateral slip
params.QDRP1 = 1.0; %Maximum turning moment
params.QDRP2 = -1.5; %Location of maximum turning moment
%--------------------------------------------contact patch parameters
params.PA1 = 0.4147; %Half contact length dependency on Fz)
params.PA2 = 1.9129; %Half contact length dependency on sqrt(Fz/R0)
%--------------------------------------------contact patch slip model
params.MC = 1.0; %Contact mass
params.IC = 0.05; %Contact moment of inertia
params.KX = 409.0; %Contact longitudinal damping
params.KY = 320.8; %Contact lateral damping
params.KP = 11.9; %Contact yaw damping
params.CX = 4.350e+005; %Contact longitudinal stiffness
params.CY = 1.665e+005; %Contact lateral stiffness
params.CP = 20319; %Contact yaw stiffness
params.EP = 1.0;
params.EP12 = 4.0;
params.BF2 = 0.5;
params.BP1 = 0.5;
params.BP2 = 0.67;
%------------------------------------------------------loaded radius
params.QV1 = 0.000071; %Tire radius growth coefficient
params.QV2 = 2.489; %Tire stiffness variation coefficient with speed
params.QFCX1 = 0.1; %Tire stiffness interaction with Fx
params.QFCY1 = 0.3; %Tire stiffness interaction with Fy
params.QFCG1 = 0.0; %Tire stiffness interaction with camber
params.QFZ1 = 0.0; %Linear stiffness coefficient, if zero,
params.QFZ2 = 14.35; %Tire vertical stiffness coefficient (quadratic)
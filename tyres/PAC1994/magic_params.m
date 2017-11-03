function [aParams,bParams,cParams] = magic_params()
%MAGAIC_PARAMS Returns a default set of tyre parameters for magic_model
%   Author: N.Martin - 25.10.17

% Parameter	Role                                                        Units       Typical range	Sample
% a0        Shape factor                                                            1.2 .. 18       1.4
% a1        Load influence on lateral friction coefficient (*1000)      1/kN        -80 .. +80      0
% a2        Lateral friction coefficient (*1000)                                    900 .. 1700     1100
% a3        Change of stiffness with slip                               N/deg       500 .. 2000     1100
% a4        Change of progressivity of stiffness / load                 1/kN        0 .. 50         10
% a5        Camber influence on stiffness                               %/deg/100	-0.1 .. +0.1	0
% a6        Curvature change with load                                              -2 .. +2        0
% a7        Curvature factor                                                        -20 .. +1       -2
% a8        Load influence on horizontal shift                          deg/kN      -1 .. +1        0
% a9        Horizontal shift at load = 0 and camber = 0                 deg         -1 .. +1        0
% a10       Camber influence on horizontal shift                        deg/deg     -0.1 .. +0.1	0
% a11       Vertical shift                                              N           -200 .. +200	0
% a12       Vertical shift at load = 0                                  N           -10 .. +10      0
% a13       Camber influence on vertical shift, load dependent          N/deg/kN	-10 .. +10      0
% a14       Camber influence on vertical shift                          N/deg       -15 .. +15      0
% a15       Camber influence on lateral friction coefficient            1/deg       -0.01 .. +0.01	0
% a16       Curvature change with camber                                            -0.1 .. +0.1	0
% a17       Curvature shift                                                         -1 .. +1        0

aParams.a0 = 1.7;
aParams.a1 = 0;
aParams.a2 = 1100;
aParams.a3 = 1100;
aParams.a4 = 10;
aParams.a5 = 0.1;
aParams.a6 = 0;
aParams.a7 = -4;
aParams.a8 = 0;
aParams.a9 = 0;
aParams.a10 = -0.1;
aParams.a11 = 0;
aParams.a12 = 0;
aParams.a13 = 1.3;
aParams.a14 = -0.2;
aParams.a15 = 0.002;
aParams.a16 = 0.6;
aParams.a17 = 0;
% aParams.a0 = 1.5535430e+00;
% aParams.a1 = -1.2854474e+01;
% aParams.a2 = -1.1133711e+03;
% aParams.a3 = -4.4104698e+03;
% aParams.a4 = -1.2518279e+01;
% aParams.a5 = -2.4000120e-03;
% aParams.a6 = 6.5642332e-02;
% aParams.a7 = 2.0865589e-01;
% aParams.a8 = -1.5717978e-02;
% aParams.a9 = 5.8287762e-02;
% aParams.a10 = -9.2761963e-02;
% aParams.a11 = 1.8649096e+01;
% aParams.a12 = -1.8642199e+02;
% aParams.a13 = 1.3462023e+00;
% aParams.a14 = -2.0845180e-01;
% aParams.a15 = 2.3183540e-03;
% aParams.a16 = 6.6483573e-01;
% aParams.a17 = 3.5017404e-01;

% Parameter	Role                                                        Units       Typical range	Sample
% b0        Shape factor                                                            1.4 .. 1.8      1.5
% b1        Load influence on longitudinal friction coefficient (*1000)	1/kN        -80 .. +80      0
% b2        Longitudinal friction coefficient (*1000)                               900 .. 1700     1100
% b3        Curvature factor of stiffness/load                          N/%/kN^2	-20 .. +20      0
% b4        Change of stiffness with slip                               N/%         100 .. 500      300
% b5        Change of progressivity of stiffness/load                   1/kN        -1 .. +1        0
% b6        Curvature change with load^2                                            -0.1 .. +0.1	0
% b7        Curvature change with load                                              -1 .. +1        0
% b8        Curvature factor                                                        -20 .. +1       -2
% b9        Load influence on horizontal shift                          %/kN        -1 .. +1        0
% b10       Horizontal shift                                            %           -5 .. +5        0
% b11       Vertical shift                                              N           -100 .. +100	0
% b12       Vertical shift at load = 0                                  N           -10 .. +10      0
% b13       Curvature shift                                                         -1 .. +1        0

bParams.b0 = 1.4;
bParams.b1 = 0;
bParams.b2 = 1100;
bParams.b3 = 0;
bParams.b4 = 200; %300
bParams.b5 = 0;
bParams.b6 = 0;
bParams.b7 = 0;
bParams.b8 = -2;
bParams.b9 = 0;
bParams.b10 = 0;
bParams.b11 = 0;
bParams.b12 = 0;
bParams.b13 = 0;

cParams.c0 = 2.8;
cParams.c1 = 3;
cParams.c2 = -0.5;
cParams.c3 = 25;
cParams.c4 = 15;
cParams.c5 = -1.0375348e-01;
cParams.c6 = -5.0880786e-03;
cParams.c7 = -1.3726071e-02;
cParams.c8 = -1.0000000e-01;
cParams.c9 = -6.1144302e-01;
cParams.c10 = 3.6187314e-02;
cParams.c11 = 0;%-2.3679781e-03;
cParams.c12 = 0;%1.7324400e-01;
cParams.c13 = 0;%-1.7680388e-02;
cParams.c14 = 0;%-3.4007351e-01;
cParams.c15 = 0;%-1.6418691e+00;
cParams.c16 = 0;%4.1322424e-01;
cParams.c17 = 0;%-2.3573702e-01;
cParams.c18 = 0;%6.0754417e-03;
cParams.c19 = 0;%-4.2525059e-01;
cParams.c20 = 0;%-2.1503067e-01;


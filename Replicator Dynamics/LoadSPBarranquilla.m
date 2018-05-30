%% -------------------------------------------------------------------------
% LoadSPBarranquilla.m
% -------------------------------------------------------------------------
% Trafic Signal Plans
% By Joan Villamil and Pablo Ñañez
% Universidad de los Andes - IMATIC
% Bogot?, Colombia
% April 2012
% -------------------------------------------------------------------------
%% -------------------------------------------------------------------------
% VARIABLE NAMES AND EXPLICATION
% -------------------------------------------------------------------------

% Example 01
% Four controllers
% Controller 1: Calle 82 con Carrera 52
% Controller 2: Calle 82 con Carrera 51B
% Controller 3: Calle 82 con Carrera 51
% Controller 4: Calle 82 con Carrera 50
% Controller 5: Calle 84 con Carrera 52
% Controller 6: Calle 84 con Carrera 51B
% Controller 7: Calle 84 con Carrera 51
% Controller 8: Calle 84 con Carrera 50

% SpDB{i,j,k,l}: Signal plan Data Base.
% Spx = GetSp(inGreen,minTao,TC,orden);
% SpX{q,c,1} = Spx{1};
% SpX{q,c,2} = Spx{2};
% q) Signal plan
% c) Controller
% k = 1) Signal state matrix (signal groups x number of states)
% k = 2) Time vector
% Case 1
% orden{signalGroup} = (phases) [1 2 4 5] - (RA V A R)
% minTao Case 1 (1 2 4 5 - RA V A R)
% minTao{signalGroup} = [minRA TV minAmb -1]
% Case 2
% orden{signalGroup} = (phases) [2 3 5] - (V Vint R)
% minTao Case 2 (2 3 5 - V Vint R)
% minTao{signalGroup} = [TV minVint -1]

%% -------------------------------------------------------------------------
% Plan 1
% -------------------------------------------------------------------------

% Controller 1: Calle 82 con Carrera 52
% PLAN 1
orden{1} = [1 2 4 5];
orden{2} = [1 2 4 5];
orden{3} = [2 3 5];
orden{4} = [2 3 5];
minTao{1} = [2 27 3 -1];
minTao{2} = [2 23 3 -1];
minTao{3} = [21 2 -1];
minTao{4} = [25 2 -1];
TC = 60;
inGreen = [38 10 12 39];
Spx = GetSp(inGreen,minTao,TC,orden);
SpX{1,1,1} = Spx{1};
SpX{1,1,2} = Spx{2};
% Controller 2: Calle 82 con Carrera 51B
% PLAN 1
orden{1} = [1 2 4 5];
orden{2} = [1 2 4 5];
orden{3} = [2 3 5];
orden{4} = [2 3 5];
minTao{1} = [2 28 3 -1];
minTao{2} = [2 22 3 -1];
minTao{3} = [21 2 -1];
minTao{4} = [26 2 -1];
TC = 60;
inGreen = [42 15 16 44];
Spx = GetSp(inGreen,minTao,TC,orden);
SpX{1,2,1} = Spx{1};
SpX{1,2,2} = Spx{2};
% Controller 3: Calle 82 con Carrera 51
% PLAN 1
orden{1} = [1 2 4 5];
orden{2} = [1 2 4 5];
orden{3} = [2 3 5];
orden{4} = [2 3 5];
minTao{1} = [2 31 3 -1];
minTao{2} = [2 19 3 -1];
minTao{3} = [17 2 -1];
minTao{4} = [29 2 -1];
TC = 60;
inGreen = [47 23 24 48];
Spx = GetSp(inGreen,minTao,TC,orden);
SpX{1,3,1} = Spx{1};
SpX{1,3,2} = Spx{2};
% Controller 4: Calle 82 con Carrera 50
% PLAN 1
orden{1} = [1 2 4 5];
orden{2} = [1 2 4 5];
orden{3} = [2 3 5];
orden{4} = [2 3 5];
minTao{1} = [2 31 3 -1];
minTao{2} = [2 19 3 -1];
minTao{3} = [17 2 -1];
minTao{4} = [29 2 -1];
TC = 60;
inGreen = [52 28 29 53];
Spx = GetSp(inGreen,minTao,TC,orden);
SpX{1,4,1} = Spx{1};
SpX{1,4,2} = Spx{2};
% Controller 5: Calle 84 con Carrera 52
% PLAN 1
orden{1} = [1 2 4 5];
orden{2} = [1 2 4 5];
orden{3} = [2 3 5];
orden{4} = [2 3 5];
minTao{1} = [2 26 3 -1];
minTao{2} = [2 23 3 -1];
minTao{3} = [20 2 -1];
minTao{4} = [25 2 -1];
TC = 60;
inGreen = [28 59 0 28];
Spx = GetSp(inGreen,minTao,TC,orden);
SpX{1,5,1} = Spx{1};
SpX{1,5,2} = Spx{2};
% Controller 6: Calle 84 con Carrera 51B
% PLAN 1
orden{1} = [1 2 4 5];
orden{2} = [1 2 4 5];
orden{3} = [2 3 5];
orden{4} = [2 3 5];
minTao{1} = [2 27 3 -1];
minTao{2} = [2 23 3 -1];
minTao{3} = [19 2 -1];
minTao{4} = [25 2 -1];
TC = 60;
inGreen = [13 45 47 15];
Spx = GetSp(inGreen,minTao,TC,orden);
SpX{1,6,1} = Spx{1};
SpX{1,6,2} = Spx{2};
% Controller 7: Calle 84 con Carrera 51
% PLAN 1
orden{1} = [1 2 4 5];
orden{2} = [1 2 4 5];
orden{3} = [2 3 5];
orden{4} = [2 3 5];
minTao{1} = [2 27 3 -1];
minTao{2} = [2 23 3 -1];
minTao{3} = [20 2 -1];
minTao{4} = [26 2 -1];
TC = 60;
inGreen = [2 34 35 3];
Spx = GetSp(inGreen,minTao,TC,orden);
SpX{1,7,1} = Spx{1};
SpX{1,7,2} = Spx{2};
% Controller 8: Calle 84 con Carrera 50
% PLAN 1
orden{1} = [1 2 4 5];
orden{2} = [1 2 4 5];
minTao{1} = [2 29 3 -1];
minTao{2} = [2 20 3 -1];
TC = 60;
inGreen = [56 30];
Spx = GetSp(inGreen,minTao,TC,orden);
SpX{1,8,1} = Spx{1};
SpX{1,8,2} = Spx{2};

%% -------------------------------------------------------------------------
% Plan 2
% -------------------------------------------------------------------------
% Controller 1: Calle 82 con Carrera 52
% PLAN 2
orden{1} = [1 2 4 5];
orden{2} = [1 2 4 5];
orden{3} = [2 3 5];
orden{4} = [2 3 5];
minTao{1} = [2 32 3 -1];
minTao{2} = [2 33 3 -1];
minTao{3} = [31 2 -1];
minTao{4} = [30 2 -1];
TC = 75;
inGreen = [42 4 6 43];
Spx = GetSp(inGreen,minTao,TC,orden);
SpX{2,1,1} = Spx{1};
SpX{2,1,2} = Spx{2};
% Controller 2: Calle 82 con Carrera 51B
% PLAN 2
orden{1} = [1 2 4 5];
orden{2} = [1 2 4 5];
orden{3} = [2 3 5];
orden{4} = [2 3 5];
minTao{1} = [2 33 3 -1];
minTao{2} = [2 32 3 -1];
minTao{3} = [31 2 -1];
minTao{4} = [31 2 -1];
TC = 75;
inGreen = [37 0 1 39];
Spx = GetSp(inGreen,minTao,TC,orden);
SpX{2,2,1} = Spx{1};
SpX{2,2,2} = Spx{2};
% Controller 3: Calle 82 con Carrera 51
% PLAN 2
orden{1} = [1 2 4 5];
orden{2} = [1 2 4 5];
orden{3} = [2 3 5];
orden{4} = [2 3 5];
minTao{1} = [2 41 3 -1];
minTao{2} = [2 24 3 -1];
minTao{3} = [22 2 -1];
minTao{4} = [39 2 -1];
TC = 75;
inGreen = [33 4 5 34];
Spx = GetSp(inGreen,minTao,TC,orden);
SpX{2,3,1} = Spx{1};
SpX{2,3,2} = Spx{2};
% Controller 4: Calle 82 con Carrera 50
% PLAN 2
orden{1} = [1 2 4 5];
orden{2} = [1 2 4 5];
orden{3} = [2 3 5];
orden{4} = [2 3 5];
minTao{1} = [2 41 3 -1];
minTao{2} = [2 24 3 -1];
minTao{3} = [22 2 -1];
minTao{4} = [39 2 -1];
TC = 75;
inGreen = [28 74 0 29];
Spx = GetSp(inGreen,minTao,TC,orden);
SpX{2,4,1} = Spx{1};
SpX{2,4,2} = Spx{2};
% Controller 5: Calle 84 con Carrera 52
% PLAN 2
orden{1} = [1 2 4 5];
orden{2} = [1 2 4 5];
orden{3} = [2 3 5];
orden{4} = [2 3 5];
minTao{1} = [2 35 3 -1];
minTao{2} = [2 29 3 -1];
minTao{3} = [26 2 -1];
minTao{4} = [34 2 -1];
TC = 75;
inGreen = [72 37 38 72];
Spx = GetSp(inGreen,minTao,TC,orden);
SpX{2,5,1} = Spx{1};
SpX{2,5,2} = Spx{2};
% Controller 6: Calle 84 con Carrera 51B
% PLAN 2
orden{1} = [1 2 4 5];
orden{2} = [1 2 4 5];
orden{3} = [2 3 5];
orden{4} = [2 3 5];
minTao{1} = [2 34 3 -1];
minTao{2} = [2 31 3 -1];
minTao{3} = [27 2 -1];
minTao{4} = [32 2 -1];
TC = 75;
inGreen = [62 26 28 64];
Spx = GetSp(inGreen,minTao,TC,orden);
SpX{2,6,1} = Spx{1};
SpX{2,6,2} = Spx{2};
% Controller 7: Calle 84 con Carrera 51
% PLAN 2
orden{1} = [1 2 4 5];
orden{2} = [1 2 4 5];
orden{3} = [2 3 5];
orden{4} = [2 3 5];
minTao{1} = [2 35 3 -1];
minTao{2} = [2 30 3 -1];
minTao{3} = [27 2 -1];
minTao{4} = [34 2 -1];
TC = 75;
inGreen = [66 31 32 67];
Spx = GetSp(inGreen,minTao,TC,orden);
SpX{2,7,1} = Spx{1};
SpX{2,7,2} = Spx{2};
% Controller 8: Calle 84 con Carrera 50
% PLAN 2
orden{1} = [1 2 4 5];
orden{2} = [1 2 4 5];
minTao{1} = [2 35 3 -1];
minTao{2} = [2 29 3 -1];
TC = 75;
inGreen = [69 34];
Spx = GetSp(inGreen,minTao,TC,orden);
SpX{2,8,1} = Spx{1};
SpX{2,8,2} = Spx{2};
%% -------------------------------------------------------------------------
% Plan 3
% -------------------------------------------------------------------------
% Controller 1: Calle 82 con Carrera 52
% PLAN 3
orden{1} = [1 2 4 5];
orden{2} = [1 2 4 5];
orden{3} = [2 3 5];
orden{4} = [2 3 5];
minTao{1} = [2 40 3 -1];
minTao{2} = [2 40 3 -1];
minTao{3} = [38 2 -1];
minTao{4} = [38 2 -1];
TC = 90;
inGreen = [48 3 5 49];
Spx = GetSp(inGreen,minTao,TC,orden);
SpX{3,1,1} = Spx{1};
SpX{3,1,2} = Spx{2};
% Controller 2: Calle 82 con Carrera 51B
% PLAN 3
orden{1} = [1 2 4 5];
orden{2} = [1 2 4 5];
orden{3} = [2 3 5];
orden{4} = [2 3 5];
minTao{1} = [2 41 3 -1];
minTao{2} = [2 39 3 -1];
minTao{3} = [38 2 -1];
minTao{4} = [39 2 -1];
TC = 90;
inGreen = [43 89 0 45];
Spx = GetSp(inGreen,minTao,TC,orden);
SpX{3,2,1} = Spx{1};
SpX{3,2,2} = Spx{2};
% Controller 3: Calle 82 con Carrera 51
% PLAN 3
orden{1} = [1 2 4 5];
orden{2} = [1 2 4 5];
orden{3} = [2 3 5];
orden{4} = [2 3 5];
minTao{1} = [2 45 3 -1];
minTao{2} = [2 35 3 -1];
minTao{3} = [33 2 -1];
minTao{4} = [43 2 -1];
TC = 90;
inGreen = [38 88 89 39];
Spx = GetSp(inGreen,minTao,TC,orden);
SpX{3,3,1} = Spx{1};
SpX{3,3,2} = Spx{2};
% Controller 4: Calle 82 con Carrera 50
% PLAN 3
orden{1} = [1 2 4 5];
orden{2} = [1 2 4 5];
orden{3} = [2 3 5];
orden{4} = [2 3 5];
minTao{1} = [2 45 3 -1];
minTao{2} = [2 35 3 -1];
minTao{3} = [33 2 -1];
minTao{4} = [43 2 -1];
TC = 90;
inGreen = [33 83 84 34];
Spx = GetSp(inGreen,minTao,TC,orden);
SpX{3,4,1} = Spx{1};
SpX{3,4,2} = Spx{2};
% Controller 5: Calle 84 con Carrera 52
% PLAN 3
orden{1} = [1 2 4 5];
orden{2} = [1 2 4 5];
orden{3} = [2 3 5];
orden{4} = [2 3 5];
minTao{1} = [2 43 3 -1];
minTao{2} = [2 36 3 -1];
minTao{3} = [33 2 -1];
minTao{4} = [42 2 -1];
TC = 90;
inGreen = [71 29 30 71];
Spx = GetSp(inGreen,minTao,TC,orden);
SpX{3,5,1} = Spx{1};
SpX{3,5,2} = Spx{2};
% Controller 6: Calle 84 con Carrera 51B
% PLAN 3
orden{1} = [1 2 4 5];
orden{2} = [1 2 4 5];
orden{3} = [2 3 5];
orden{4} = [2 3 5];
minTao{1} = [2 40 3 -1];
minTao{2} = [2 40 3 -1];
minTao{3} = [36 2 -1];
minTao{4} = [38 2 -1];
TC = 90;
inGreen = [61 16 18 63];
Spx = GetSp(inGreen,minTao,TC,orden);
SpX{3,6,1} = Spx{1};
SpX{3,6,2} = Spx{2};
% Controller 7: Calle 84 con Carrera 51
% PLAN 3
orden{1} = [1 2 4 5];
orden{2} = [1 2 4 5];
orden{3} = [2 3 5];
orden{4} = [2 3 5];
minTao{1} = [2 41 3 -1];
minTao{2} = [2 39 3 -1];
minTao{3} = [36 2 -1];
minTao{4} = [40 2 -1];
TC = 90;
inGreen = [65 21 22 66];
Spx = GetSp(inGreen,minTao,TC,orden);
SpX{3,7,1} = Spx{1};
SpX{3,7,2} = Spx{2};
% Controller 8: Calle 84 con Carrera 50
% PLAN 3
orden{1} = [1 2 4 5];
orden{2} = [1 2 4 5];
minTao{1} = [2 43 3 -1];
minTao{2} = [2 36 3 -1];
TC = 90;
inGreen = [68 26];
Spx = GetSp(inGreen,minTao,TC,orden);
SpX{3,8,1} = Spx{1};
SpX{3,8,2} = Spx{2};
%% -------------------------------------------------------------------------
% Plan 4
% -------------------------------------------------------------------------
% Controller 1: Calle 82 con Carrera 52
% PLAN 4
orden{1} = [1 2 4 5];
orden{2} = [1 2 4 5];
orden{3} = [2 3 5];
orden{4} = [2 3 5];
minTao{1} = [2 20 3 -1];
minTao{2} = [2 15 3 -1];
minTao{3} = [13 2 -1];
minTao{4} = [18 2 -1];
TC = 45;
inGreen = [30 10 12 31];
Spx = GetSp(inGreen,minTao,TC,orden);
SpX{4,1,1} = Spx{1};
SpX{4,1,2} = Spx{2};
% Controller 2: Calle 82 con Carrera 51B
% PLAN 4
orden{1} = [1 2 4 5];
orden{2} = [1 2 4 5];
orden{3} = [2 3 5];
orden{4} = [2 3 5];
minTao{1} = [2 21 3 -1];
minTao{2} = [2 14 3 -1];
minTao{3} = [13 2 -1];
minTao{4} = [19 2 -1];
TC = 45;
inGreen = [34 15 16 36];
Spx = GetSp(inGreen,minTao,TC,orden);
SpX{4,2,1} = Spx{1};
SpX{4,2,2} = Spx{2};
% Controller 3: Calle 82 con Carrera 51
% PLAN 4
orden{1} = [1 2 4 5];
orden{2} = [1 2 4 5];
orden{3} = [2 3 5];
orden{4} = [2 3 5];
minTao{1} = [2 23 3 -1];
minTao{2} = [2 12 3 -1];
minTao{3} = [10 2 -1];
minTao{4} = [21 2 -1];
TC = 45;
inGreen = [39 22 23 40];
Spx = GetSp(inGreen,minTao,TC,orden);
SpX{4,3,1} = Spx{1};
SpX{4,3,2} = Spx{2};
% Controller 4: Calle 82 con Carrera 50
% PLAN 4
orden{1} = [1 2 4 5];
orden{2} = [1 2 4 5];
orden{3} = [2 3 5];
orden{4} = [2 3 5];
minTao{1} = [2 23 3 -1];
minTao{2} = [2 12 3 -1];
minTao{3} = [10 2 -1];
minTao{4} = [21 2 -1];
TC = 45;
inGreen = [44 27 28 0];
Spx = GetSp(inGreen,minTao,TC,orden);
SpX{4,4,1} = Spx{1};
SpX{4,4,2} = Spx{2};
% Controller 5: Calle 84 con Carrera 52
% PLAN 4
orden{1} = [1 2 4 5];
orden{2} = [1 2 4 5];
orden{3} = [2 3 5];
orden{4} = [2 3 5];
minTao{1} = [2 18 3 -1];
minTao{2} = [2 16 3 -1];
minTao{3} = [13 2 -1];
minTao{4} = [17 2 -1];
TC = 45;
inGreen = [24 2 3 24];
Spx = GetSp(inGreen,minTao,TC,orden);
SpX{4,5,1} = Spx{1};
SpX{4,5,2} = Spx{2};
% Controller 6: Calle 84 con Carrera 51B
% PLAN 4
orden{1} = [1 2 4 5];
orden{2} = [1 2 4 5];
orden{3} = [2 3 5];
orden{4} = [2 3 5];
minTao{1} = [2 19 3 -1];
minTao{2} = [2 16 3 -1];
minTao{3} = [12 2 -1];
minTao{4} = [17 2 -1];
TC = 45;
inGreen = [13 37 39 15];
Spx = GetSp(inGreen,minTao,TC,orden);
SpX{4,6,1} = Spx{1};
SpX{4,6,2} = Spx{2};
% Controller 7: Calle 84 con Carrera 51
% PLAN 4
orden{1} = [1 2 4 5];
orden{2} = [1 2 4 5];
orden{3} = [2 3 5];
orden{4} = [2 3 5];
minTao{1} = [2 20 3 -1];
minTao{2} = [2 15 3 -1];
minTao{3} = [12 2 -1];
minTao{4} = [19 2 -1];
TC = 45;
inGreen = [9 34 35 10];
Spx = GetSp(inGreen,minTao,TC,orden);
SpX{4,7,1} = Spx{1};
SpX{4,7,2} = Spx{2};
% Controller 8: Calle 84 con Carrera 50
% PLAN 4
orden{1} = [1 2 4 5];
orden{2} = [1 2 4 5];
minTao{1} = [2 20 3 -1];
minTao{2} = [2 14 3 -1];
TC = 45;
inGreen = [3 28];
Spx = GetSp(inGreen,minTao,TC,orden);
SpX{4,8,1} = Spx{1};
SpX{4,8,2} = Spx{2};

SpDB = SpX;

%% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% "Sincronia" and "Conexión" flags
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% SigmaFlags(i,j,{k})
% i = Signal plan
% j = controller
% k =1 => sigma = jump phase objective
% k =2 => tao = jump counter objective


%% -------------------------------------------------------------------------
% 
% -------------------------------------------------------------------------
% Controller 1: Calle 82 con Carrera 52
% 
ic = 1;
SincroniaFlags(1,ic,1) = 6;
SincroniaFlags(2,ic,2) = 0;
SincroniaFlags(3,ic,1) = 3;
SincroniaFlags(4,ic,2) = 0;
SincroniaFlags(5,ic,1) = 3;
SincroniaFlags(6,ic,2) = 0;
SincroniaFlags(7,ic,1) = 6;
SincroniaFlags(8,ic,2) = 0;

ic = 2;
SincroniaFlags(1,ic,1) = 6;
SincroniaFlags(2,ic,2) = 0;
SincroniaFlags(3,ic,1) = 2;
SincroniaFlags(4,ic,2) = 0;
SincroniaFlags(5,ic,1) = 1;
SincroniaFlags(6,ic,2) = 0;
SincroniaFlags(7,ic,1) = 6;
SincroniaFlags(8,ic,2) = 0;

ic = 3;
SincroniaFlags(1,ic,1) = 7;
SincroniaFlags(2,ic,2) = 0;
SincroniaFlags(3,ic,1) = 4;
SincroniaFlags(4,ic,2) = 0;
SincroniaFlags(5,ic,1) = 1;
SincroniaFlags(6,ic,2) = 0;
SincroniaFlags(7,ic,1) = 1;
SincroniaFlags(8,ic,2) = 0;

ic = 4;
SincroniaFlags(1,ic,1) = 7;
SincroniaFlags(2,ic,2) = 0;
SincroniaFlags(3,ic,1) = 7;
SincroniaFlags(4,ic,2) = 0;
SincroniaFlags(5,ic,1) = 7;
SincroniaFlags(6,ic,2) = 0;
SincroniaFlags(7,ic,1) = 7;
SincroniaFlags(8,ic,2) = 0;

ic = 5;
SincroniaFlags(1,ic,1) = 1;
SincroniaFlags(2,ic,2) = 0;
SincroniaFlags(3,ic,1) = 7;
SincroniaFlags(4,ic,2) = 0;
SincroniaFlags(5,ic,1) = 7;
SincroniaFlags(6,ic,2) = 0;
SincroniaFlags(7,ic,1) = 4;
SincroniaFlags(8,ic,2) = 0;

ic = 6;
SincroniaFlags(1,ic,1) = 10;
SincroniaFlags(2,ic,2) = 0;
SincroniaFlags(3,ic,1) = 5;
SincroniaFlags(4,ic,2) = 0;
SincroniaFlags(5,ic,1) = 5;
SincroniaFlags(6,ic,2) = 0;
SincroniaFlags(7,ic,1) = 1;
SincroniaFlags(8,ic,2) = 0;

ic = 7;
SincroniaFlags(1,ic,1) = 9;
SincroniaFlags(2,ic,2) = 0;
SincroniaFlags(3,ic,1) = 6;
SincroniaFlags(4,ic,2) = 0;
SincroniaFlags(5,ic,1) = 6;
SincroniaFlags(6,ic,2) = 0;
SincroniaFlags(7,ic,1) = 12;
SincroniaFlags(8,ic,2) = 0;


ic = 8;
SincroniaFlags(1,ic,1) = 4;
SincroniaFlags(2,ic,2) = 0;
SincroniaFlags(3,ic,1) = 4;
SincroniaFlags(4,ic,2) = 0;
SincroniaFlags(5,ic,1) = 4;
SincroniaFlags(6,ic,2) = 0;
SincroniaFlags(7,ic,1) = 7;
SincroniaFlags(8,ic,2) = 0;







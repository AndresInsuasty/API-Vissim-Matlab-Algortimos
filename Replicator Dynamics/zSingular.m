clear all
clc
close all
reset(symengine)

l = zeros(9,9);
A21 = rand(4,5)>0.5;
l(1:4,5:9) = -A21;
l(5:9,1:4) = A21';
A11 = rand(5).*eye(5);
l(5:9,5:9) = A11;
inv(l)


clear all
clc
close all
v = 6;
nT = 2;
nv = 4;
p = 6;

A11 = rand(p).*eye(p);

Acs = rand(v).*eye(v);
f = zeros(v+nT);
f(1:v,1:v) = -Acs;
b = zeros(v+nT,nv-nT+p+v);
A22_1 = rand(nT).*eye(nT);
A21_1 = rand(nT,p)>0.5
b(v+1:end,nT+1:nv-nT+p) = -A22_1*A21_1;
b(1:v,nv-nT+p+1:end) = Acs;

Co=ctrb(f,b);
% Number of uncontrollable states
unco=length(f)-rank(Co)

C = zeros(v+nv+p+v,v+nT);
C1 = eye(v+nT);
C(1:v+nT,1:v+nT) = C1;
D = zeros(v+nv+p+v,nv-nT+p+v);
D1 = eye(nv-nT+p+v);
D(v+nv-nT+1:end,1:nv-nT+p+v) = D1;

Ob = obsv(f,C);

% Number of unobservable states
unob = length(f)-rank(Ob)

%% funciones de transferencia
A = f;
B = b;
iu = 14;
[num,den] = ss2tf(A,B,C,D,iu);

%% new psi

syms a1 a2 a3 a4 a5 a6
clear A11;
A11(1,1) = a1; A11(2,2) = a2; A11(3,3) = a3; A11(4,4) = a4; A11(5,5) = a5; A11(6,6) = a6;
F = sym(zeros(p+nv-nT));

F(nv-nT+1:end,nv-nT+1:end) = vpa(A11);

A21_2 = (rand(nv-nT,p)>0.5)*2-1
A12_2 = A21_2';
F(1:nv-nT,nv-nT+1:end) = -A21_2;
F(nv-nT+1:end,1:nv-nT) = A12_2;

inv(F)

%% V >=0

syms k1 k2 k3 k4 'real'
syms m1 m2 m3 m4 'real'
V = sym(zeros(8));
a = 1/2;
V(1,1) = k1;
V(2,2) = k2;
V(3,3) = k3;
V(4,4) = k4;
V(5,1) = a;
V(6,2) = a;
V(7,3) = a;
V(8,4) = a;
V(1,5) = a;
V(2,6) = a;
V(3,7) = a;
V(4,8) = a;
V
ev = eig(V)
% KK = solve('k1/2 - 32*(k1^2/4096 + 1/4096)^(1/2) = 0','k1/2 + 32*(k1^2/4096 + 1/4096)^(1/2) = 0',...
%     'k2/2 - 32*(k2^2/4096 + 1/4096)^(1/2) = 0','k2/2 + 32*(k2^2/4096 + 1/4096)^(1/2) = 0',...
%     'k3/2 - 32*(k3^2/4096 + 1/4096)^(1/2) = 0','k3/2 + 32*(k3^2/4096 + 1/4096)^(1/2) = 0',...
%     'k4/2 - 32*(k4^2/4096 + 1/4096)^(1/2) = 0','k4/2 + 32*(k4^2/4096 + 1/4096)^(1/2) = 0')
% iki = 0
% ks = -1:0.1:1;
% for ki = ks
%     iki = iki +1;
%     l1(iki)  = ki/2 - 32*(ki^2/4096 + 1/4096)^(1/2);
%     l1p(iki) = ki/2 + 32*(ki^2/4096 + 1/4096)^(1/2);
% end
% figure
% plot(ks,[l1' l1p'])

%% Y^T(U-K1Y)>0, [U-K1Y]^T[U-K2Y]<=0

syms ex1 ex2 eh1 eh2 h3 Q12 Q23 Q13 k11 k12 k13 k14 k21 k22 k23 k24 'real'
kk = [k11*k21 k12*k22 k13*k23 k14*k24 1 1 1 1];
kvar = [-(k11+k21)/2 -(k12+k22)/2 -(k13+k23)/2 -(k14+k24)/2];
clear V
V = diag(kk) + diag(kvar,4) + diag(kvar,-4)

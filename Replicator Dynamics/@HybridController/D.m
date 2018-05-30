function [v] = D(z) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file                Author: Pablo Ñañez
%
% Project: Simulation of a hybrid system (Traffic control IMATIC)
%
% Name: D.m
%
% Description: Jump set
%
% Version: 0.1
% Required files: -
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% constants
global  n m Sp;
%n = # of state components
%m = # of input components
% state
x     = z(1:n);
tao   = x(1);
q     = round(max(1,x(2)));
sigma = round(max(1,x(3)));
xt    = x(4:end-1);
delta = x(end);

%input
u       = z(n+1:n+m);
tao_u   = u(1);
q_u     = u(2);
sigma_u = u(3);
x_u     = u(4:end-1);
delta_u = u(end);

nsg = length(xt); % Number of signal groups
d1 = (sum(xt==x_u)==nsg) && (q~=q_u||sigma~=sigma_u||tao<tao_u) && (delta_u==1);
d2 = tao>=Sp{2}(sigma); % if the counter reach the time limit for this machine state
if d1||d2   % jump condition
    v = 1;  % report jump
else
    v = 0;   % do not report jump
end
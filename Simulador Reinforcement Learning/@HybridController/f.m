function out = f(z)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file                Author: Pablo Ñañez
%
% Project: Simulation of a hybrid system (Traffic controller IMATIC)
%
% Name: f.m
%
% Description: Flow map
%
% Version: 0.1
% Required files: -
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% constants
global  n m; 
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

% flow map
%xdot=f(x,u);
xdot = zeros(n,1);
xdot(1) = 1;
udot = zeros(m,1);
out = [xdot;udot];
end
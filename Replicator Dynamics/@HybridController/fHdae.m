function xdot = f(z)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file                Author: Pablo ?a?ez
%
% Project: Simulation of a DAE hybrid system
%
% Name: f.m
%
% Description: Flow map
%
% Version: 0.4
% Required files: -
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% constants
global A B;
    %n = # of state components
    %m = # of input components  
    
% state
x = z;
sigma = round(z(end));
% vw  = T{q}\x;
%input

% flow map
%xdot=f(x,u);
Aq = A(:,:,sigma);
xdot = Aq*x+B(:,:,sigma);

end
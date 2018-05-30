function [v] = D(z)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file                Author: Pablo ?a?ez
%
% Project: Simulation of a DAE hybrid system (Replicator Dynamics)
%
% Name: D.m
%
% Description: Set of Jump set
%
% Version: 0.4
% Required files: -
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% constants 
%n = # of state components
%m = # of input components
% state
x   = z(1:end-1);
sigma = round(z(end));
switch sigma
    case 1
        if x(1) <= 0.36 && x(1)>=0.3 %jump condition
            v = 1;  % report jump
        else
            v = 0;   % do not report jump
        end
    case 2
        if x(1) <= 0.53 && x(1)>=0.47 %jump condition
            v = 1;  % report jump
        else
            v = 0;   % do not report jump
        end
end
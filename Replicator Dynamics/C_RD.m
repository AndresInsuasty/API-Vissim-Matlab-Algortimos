function [v] = C(z)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file                Author: Pablo ?a?ez
%
% Project: Simulation of a DAE hybrid system (Replicator Dynamics)
%
% Name: C.m
%
% Description: Set of Flow sets
%
% Version: 0.4
% Required files: -
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% constants
%n = # of state components
%m = # of input components
% state
x   = z(:,end);
sigma = round(z(end));
switch sigma
    case 1
        if x(1) >= 0.36||x(1)<=0.3 %flow condition
            v = 1;  % report flow
        else
            v = 0;   % do not report flow
        end
    case 2
        if x(1) >= 0.53 || x(1)<=0.47 %flow condition
            v = 1;  % report flow
        else
            v = 0;   % do not report flow
        end
end
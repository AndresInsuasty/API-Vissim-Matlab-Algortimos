function [v] = Csigma(z,Cea,epsilon)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file                Author: Pablo ?a?ez
%
% Project: Simulation of a DAE hybrid system (Replicator Dynamics)
%
% Name: Csigma.m
%
% Description: Consistency space, or Set of consistency sets
%
% Version: 0.4
% Required files: -
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% constants
%n = # of state components
%m = # of input components
% state
x   = z(1:end);
sigma = round(z(end));
Ceaq = Cea{sigma};
CeaXp = [Ceaq x];
minSV = min(svd(CeaXp));
if minSV >= epsilon;% jump condition
    v = 1;  % report jump
else
    v = 0;   % do not report jump
end
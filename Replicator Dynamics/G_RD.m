function out = G(z)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file                Author: Pablo ?a?ez
%
% Project: Simulation of a hybrid DAE systems
%
% Name: G.m
%
% Description: Jump map
%
% Version: 0.4
% Required files: -
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% constants
% state
x = z;
sigma = round(z(end));
switch sigma
    case 1
        xplus = x;
        %         xplus(end) = 3-xplus(end);
        xplus(end) = 1;
    case 2
        xplus = x;
        %         xplus(end) = 3-xplus(end);
        xplus(end) = 1;        
end
out = [xplus];
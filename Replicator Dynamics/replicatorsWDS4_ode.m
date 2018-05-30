function dpdt = replicatorsWDS4_ode(t,p,flag,f,alpha,ka,Nj)
%% -------------------------------------------------------------------------
% replicatorsWDS4_ode.m
% -------------------------------------------------------------------------
% Dynamics equation for Replicator Dynamics
% By Pablo Ñañez
% Based on the work of Taylor and Jonker 1978
% Universidad de los Andes
% Bogotá, Colombia
% September, 2010
% -------------------------------------------------------------------------
% Variables:
% 
% -------------------------------------------------------------------------

%% -------------------------------------------------------------------------
beta    = 0.5;
% Determination of \bar{f}
f_bari = p.*f;
% f_bari(end) = f(end);
f_bar = sum(f_bari);
% f_bar   = sum(f)/Nj;
dpdt(:,1)=beta.*p.*(f-f_bar);

function [X,H_err,X13,p] = replicatorWDS4(Ath,p0,H_all,H_ref,Qd_all,Xpos0,T,maxV)
%% -------------------------------------------------------------------------
% replicatorWDS4.m
% -------------------------------------------------------------------------
% REPLICATOR DYNAMICS CONTROLLER FOR WATER DISTRIBUTION PRESSURE CONTROL
% By Pablo Ñañez
% Based on the work of Nicanor Quijano 2007-2010
% Universidad de los Andes
% Bogotá, Colombia
% September 2010
% -------------------------------------------------------------------------
% Variables:
% f: fitness value 
% -------------------------------------------------------------------------

%% -------------------------------------------------------------------------
% Variables
% -------------------------------------------------------------------------
Tspan = Ath;                    % Time span
n = length(T)+1;                % Total number of strategies
f = zeros(n,1);                 % fitness function values
H_err = H_all-H_ref;            % Pressure error vector
AP = zeros(n-1,1);              % Flow direction vector, suitability node selection
Aqd = zeros(n-1,1);             % Flow direction vector, suitability demand selection
H_ref_mx = zeros(n-1,1);
for iT=1:length(T)
    iTf = floor(T(iT)/10);
    iTc = T(iT)-floor(T(iT)/10)*10;
    switch H_all(iTf)>H_all(iTc)
        case true               % Flow direction [f to c] => suitability (c)
            AP(iT)  = H_err(iTc);
            Aqd(iT) = -Qd_all(iTc);
            H_ref_mx(iT) = H_ref(iTc);
        case false              % Flow direction [c to f] => suitability (f)
            AP(iT) = H_err(iTf);
            Aqd(iT) = -Qd_all(iTf);            
            H_ref_mx(iT) = H_ref(iTf);            
    end
end
if sum(isnan(AP))>0
    error('Error, AP => is NaN')
    pause
end
b           = 10*max(H_ref_mx.*Aqd);            % b [EXPLAIN ME]
f(1:n-1)    = (1-Xpos0).*AP.*Aqd + b;
f(n)        = b*1.0001;           
alpha       = 1;
ka          = 1;

[t,p] = ode23s('replicatorsWDS4_ode',Tspan,p0,[],f,alpha,ka,n);
p_ss(:,1)=p(end,:);
p_ss = 12*maxV.*p_ss;
X = zeros(length(H_all));
for iT=1:length(T)
    iTf = floor(T(iT)/10);
    iTc = T(iT)-floor(T(iT)/10)*10;
    X(iTf,iTc) = min(maxV,max(0,p_ss(iT)))';
end
X13 = p_ss(end);
X = simetria(X,1);
% Xcorr = sum(p_ss==0)*.0001;
% p_ss(p_ss==0) = 0.0001;
% p_ss(end) = p_ss(end)-Xcorr;
% p(end,:) = p_ss;

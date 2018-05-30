function out = g(z)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file                Author: Pablo Ñañez
%
% Project: Simulation of a hybrid system (Traffic Controller IMATIC)
%
% Name: g.m
%
% Description: Jump map
%
% Version: 0.1
% Required files: -
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% constants
global  n m Sp SPDB idCont;
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

delta = 0;

phs = Sp{1}; % Phase plan q
[nsg mp] = size(phs); 

delta = (sum((xt-x_u)==0)==nsg) && (q~=q_u||sigma~=sigma_u||tao<tao_u) && (delta_u==1);
delta = delta + (tao>=Sp{2}(sigma))*2; % if the counter reach the time limit for this machine state
% delta = 0; there is no jump
% delta = 1; jump because of some change in the signal plan
% delta = 2; jump because of time limits
% delta = 3; jump because 1 and 2, priority =>2

circSigma = 1:1:mp;
isigma = find(circSigma==sigma,1,'first');
switch delta
    case 0
        xplus = x;
    case 1
        Sp{1} = SPDB{q_u,idCont,1};
        Sp{2} = SPDB{q_u,idCont,2};

        taoplus = tao_u;
        qplus     = q_u;
        sigmaplus = sigma_u;
        xplus     = Sp{1}(:,sigmaplus);
        deltaplus = delta;
        xplus = [taoplus qplus sigmaplus xplus' deltaplus]';    
        
    case 2
        circSigma_new = circshift(circSigma',-1)';
        taoplus   = 0;
        qplus     = q;
        sigmaplus = circSigma_new(isigma);
        xplus     = phs(:,sigmaplus);
        deltaplus = delta;
        xplus = [taoplus qplus sigmaplus xplus' deltaplus]';       
    case 3
        circSigma_new = circshift(circSigma,-1);
        taoplus   = 0;
        qplus     = q;
        sigmaplus = circSigma_new(isigma);
        xplus     = phs(:,sigmaplus);
        deltaplus = delta;
        xplus = [taoplus qplus sigmaplus xplus deltaplus]';
end
if length(xplus)~=n
    fprintf('error???')
end

out = [xplus;u];
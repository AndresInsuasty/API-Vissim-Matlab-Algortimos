function [X,H_err,X13] = replicatorWDS(H_all,H_ref,iH_err,T,maxV)
Tspan=0:10; %Segundos
n = length(T)+1;
H_err = (H_all-H_ref); % Errores siempre positivos
AP = zeros(1,n);
for iT=1:length(T)
    iTf = floor(T(iT)/10);
    iTc = T(iT)-floor(T(iT)/10)*10;
    switch H_all(iTf)>H_all(iTc)
        case true%el caudal va de f a c, por lo tanto solo importa el Ap de c
            AP(iT) = H_err(iTc);
        case false%el caudal va de c a f, por lo tanto solo importa el Ap de f
            AP(iT) = H_err(iTf);
    end
end
AP = 0.8*[H_err(1) H_err(4) H_err(1) H_err(1) H_err(7) H_err(8)...
      H_err(7) H_err(5) H_err(6) H_err(9) H_err(3) H_err(3)];
AP = AP+[iH_err(1) iH_err(4) iH_err(1) iH_err(1) iH_err(7) iH_err(8)...
      iH_err(7) iH_err(5) iH_err(6) iH_err(9) iH_err(3) iH_err(3)];
AP = max(0,AP);  
AP(n) = 0.1;%Zona de energía (13)

alpha = 1/max(AP);
% alpha = 1/30;

ka = 1;
p0 = zeros(1,n);           %Condiciones inciiales RD
p_0 = 1/n.*rand(1,n-1);
p0 = [1-sum(p_0) p_0]';
[t,p] = ode23s('replicatorsWDS_ode',Tspan,p0,[],AP,alpha,ka,n);
p_ss=p(end,:);
p_ss=4*maxV.*p_ss;
% p_ss=maxV.*p_ss;

X = zeros(length(H_all));
for iT=1:length(T)
    iTf = floor(T(iT)/10);
    iTc = T(iT)-floor(T(iT)/10)*10;
    X(iTf,iTc) = min(maxV,max(0,p_ss(iT)))';
end
X13 = p_ss(13);
X = simetria(X,1);

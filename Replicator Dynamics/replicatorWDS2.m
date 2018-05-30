function [X,H_err,X13] = replicatorWDS2(H_all,H_ref,iH_err,T,maxV)
Tspan=0:100; %Segundos
n = length(T)+1;
H_err = (H_all-H_ref); % Errores negativos
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
AP = [H_all(6)-0 H_all(9)-0];
AP(n) = H_ref(6); %+max(H_err(6),H_err(9));%Zona de energía (13)
AP = max(0,AP);  

alpha = 1/(min(AP));

ka = 1;
p0 = zeros(1,n);           %Condiciones inciiales RD
p_0 = 1/n.*rand(1,n-1);
p0 = [1-sum(p_0) p_0]';
[t,p] = ode23s('replicatorsWDS_ode',Tspan,p0,[],AP,alpha,ka,n);
p_ss=p(end,:);
p_ss=2*maxV.*p_ss;

X = zeros(length(H_all));
for iT=1:length(T)
    iTf = floor(T(iT)/10);
    iTc = T(iT)-floor(T(iT)/10)*10;
    X(iTf,iTc) = max(0,p_ss(iT))';
end
X13 = p_ss(end);
X = simetria(X,1);

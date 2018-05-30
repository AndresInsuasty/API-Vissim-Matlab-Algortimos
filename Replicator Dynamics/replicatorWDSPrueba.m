function [X,H_err,X13] = replicatorWDSPrueba(H_all,H_ref,iH_err,T,maxV)
n = length(T);
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
% AP = 1/40*[H_err(1) H_err(4) H_err(1) H_err(1) H_err(7) H_err(8)...
%       H_err(7) H_err(5) H_err(6) H_err(9) H_err(3) H_err(3)];
% AP = AP+1/60*[iH_err(1) iH_err(4) iH_err(1) iH_err(1) iH_err(7) iH_err(8)...
%       iH_err(7) iH_err(5) iH_err(6) iH_err(9) iH_err(3) iH_err(3)];
AP =  1/60*max(0,AP);  
X = zeros(length(H_all));
for iT=1:length(T)
    iTf = floor(T(iT)/10);
    iTc = T(iT)-floor(T(iT)/10)*10;
    X(iTf,iTc) = min(maxV,max(0,AP(iT)))';
end
X13 = 0;
X = simetria(X,1);

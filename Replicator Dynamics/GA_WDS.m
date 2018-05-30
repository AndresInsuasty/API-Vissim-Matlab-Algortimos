function [X,H_err,X13,p] = GA_WDS(p0,H_all,H_ref,T,maxV)
n = length(T)+1;
H_err = max(0,(H_all-H_ref)); % Errores siempre positivos
%% FITNESS
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
AP(n) = min(H_ref(2:end));%Zona de energía (13)(Minimo por que este control es inverso)
AP = max(0,AP);
[f p]=fitnessWDS(p0,AP);
%% Genetic Algorithm
tamP = size(p0);
pc=0.8; %Porcentaje de cruce
pm=0.02; %Probabilidad de mutación
pe=0.005; %Porcentaje élite
chrom_size=tamP(2); %Tamaño del cromosoma
popu_tam=tamP(1); %Tamaño de la población
gen=20; %Número de generaciones por cada At
for k=1:gen
%     [pelite felite]=elite(p0,f,pe);
    ptemp=reproduction(p0,f);
    p0=cross_over(ptemp,pc);
    p0=mutation(p0,pm);
%     p0(popu_tam-ceil(pe*popu_tam)+1:end,:) = pelite;  %the last would be the first!!!!
%     f(popu_tam-ceil(pe*popu_tam)+1:end) = felite;    %the last would be the first!!!!
    [f p]=fitnessWDS(p0,AP);
end
for iV = 1:n
    p_ss(iV) = sum(p==iV)/popu_tam;
end
p = p0;
%% De población a apertura de válvulas
p_ss=12*maxV.*p_ss;
X = zeros(length(H_all));
for iT=1:length(T)
    iTf = floor(T(iT)/10);
    iTc = T(iT)-floor(T(iT)/10)*10;
    X(iTf,iTc) = min(maxV,max(0,p_ss(iT)))';
end
X13 = p_ss(end);
X = simetria(X,1);

%April 2010
%comparation between RD and MBC
clear
close all
clc
global pn c n m
%% Definición de Variables del sistema de 13 nodos (Perfil, Cargas y Potencias Nominales)
%perfil de demanda p.u. (se realiza variación en las cargas puras PQ)
%normalizado a la mayor demanda (19:00 horas)
perfil=[1.0000 0.9762 0.9714 0.9619 1.0000 1.0905 1.1667 1.2095 1.2286 1.2476 1.3381 1.3810 1.3905 1.3476...
    1.3333 1.3429 1.3571 1.4667 1.6905 1.7095 1.6286 1.4619 1.2762 1.0714]'; %normalizado ref a carga a 1:00
perfil=perfil/max(perfil);  %normalizado referido a la máxima demanda
%cargas base asignadas a las 6 cargas a la hora 19 [P(pu) Q(pu)]
cargas=[0.0017 0.00125; 0.004 0.0029; 0.0017 0.0008; 0.00128 0.00086; 0.00843 0.00462; 0.00385 0.0022];
%Potencia nominal de los generadores en el orden que están en el archivo
%671 611 652 675 = PQgen.con [4 2 3 5]
potencias_base=[0.0015 0.00085; 0.0004 0.00025; 0.00065 0.00012; 0.00087 0.00062];
% cálculo de nivel de penetracion con base en potencia aparente total
% consumida=3.36 MVA
% S_maximas=sqrt(sum((potencias_base').^2))
% S_total_DG=sum(S_maximas)
% S_total_DG*10000/3.36

%%perfil unitario
%perfil=ones(1,24);

%% Parámetros de las funciones de utilidad
p1=172; p2=47; p3=66; p4=106; p5=60; %potencias aparentes de los DG en KW
%Número de generadores (sin contar el virtual)
n=4;    %para función MBC
%número de horas del día
nh=24;
%potencias nominales de los generadores (kVA)
pn=[p1 p2 p3 p4]';  %% ojo, vector de 4 sin el virtual
pmax=sum(pn);

%costos de los generadores
%c=[0.2 0.2 0.5 0.7];  %interesante porque dan diferentes
%c=[0.2 0.1 0.8 1];   %interesante porque dan diferentes caso 2
c=[1 0.7 0.4 0.8];  %%caso 1
%c=[1 1 1 1]*0.7;
r=1./c;
prom_pond=sum(pn'.*c);
%prom_pond=sum(pn'./(2-c));     %ojooooo con este promedio ponderado se mantiene la suma deseada
%qué tanto puede ser óptimo esta
%distribución???????
factor_demanda=1;
%factor_demanda=255/pmax;

%otras variables para RD
Pd=perfil*pmax*factor_demanda;  %vector de potencias solicitadas a cada hora
Tspan=0:5*60;                     %This would correspond to the fact that we have 1hour in seconds...
pp1=zeros(size(Tspan));

% %Parámetros y restricciones del problema de optimización (minimización
% %de costos de la energía total suministrada
Po = ones(n + 1,1) * (pmax/(n + 1));
A = [];
b = [];
Aeq = [ones(1,n + 1);zeros(n,n + 1)];
beq = [pmax;zeros(n,1)];

%Pmin = [];
%Pmax = [];

Pmin = zeros(n + 1,1);
Pmax = [100*pn;100*pmax];

%% asignación de recursos con MBC cuadrático
% increase base loading by power profile%

for i = 1:nh
    %actualización de generación de acuerdo a Market based control
    %con optimización por Newton.
    m=(pmax-Pd(i))*2/prom_pond;                 %cálculo del precio para esa potencia
    %corre algoritmos MBC
    [f,gradf]=utilities_p_cuad(pn,c,m);
    Ri=[10 10 10 10]';  %ojo, Rinicial es de n-1 elementos para variación de precios
    [Rvec,itera]=newton_1_p(Ri,f,gradf);
    P_calculada_MBC1(:,i)=Rvec(:,itera);
    
    % %actualización de generación de acuerdo a Market based control
    % %con optimización por fmincon
    [P_calculada_MBC2(:,i),utilidad_total] = fmincon('func_obj_2',Po,A,b,Aeq,beq,Pmin,Pmax);
end

%% asignación de recursos con RD continuos

for i=1:nh
    p0 = zeros(1,n);           %Condiciones inciiales RD
    p_0 = 0.3.*rand(1,n-1);
    p0 = [1-sum(p_0) p_0]';
    p0=[0.5168 0.1657 0.2220 0.0955]';
    [t,p] = ode23s('onemicrogrid_ode',Tspan,p0,[],Pd(i),pn,r,n);
    %p0 = p(end,:);
    pl(i,:)=p(end,:);
    pp1 = [pp1 p(:,1)'];                 %almacena toda la tendencia
    P_calculada_RD(i,:)=p(end,:)*Pd(i);  %únicamente el estado estacionario
    %P_calculada_RD(i,:)=p(end,:);
end
P_calculada_RD=P_calculada_RD';

%% RD discretos
% %
% for i=1:nh
% salir=1;
% alfa=500;
%
% p0 = zeros(1,n);           %Condiciones inciiales RD
% p_0 = 0.2.*rand(1,n-1);
% p0 = [1-sum(p_0) p_0];
% p_d=p0*Pd(i);
% %p_d=[0.5168 0.1657 0.2220 0.0955]*Pd(i);
% % p0=ones(1,n)/n*Pd(i);
% % p_d=p0;
%
% itera=0;
% while salir==1
%     itera=itera+1;
%     %fitness
%     for j=1:n
%        f_d(j)=r(j)*(1-p_d(j)/pn(j));
%        %f_d(j)=r(j)*(1-Pd(i)*p_d(j)/pn(j));
%        f_bari_d(j)=p_d(j)*f_d(j);
%     end
%     %fitness promedio
%     f_bar_d=1/Pd(i)*sum(f_bari_d);
%     %f_bar_d=sum(f_bari_d);
%     for j=1:n
%     pmas_d(j)=(alfa+f_d(j))/(alfa+f_bar_d)*p_d(j);
%     %otro método discreto
%     %pmas_d(j)=p_d(j)+alfa*p_d(j)*(f_d(j)-f_bar_d);
%     end
%     %error
%     error=sum(abs(pmas_d-p_d));
%     %otro error
%     %error=abs(mean(f_d)-f_bar_d);
%
%     if error<1e-6
%         salir=0;
%     end
%     p_d=pmas_d;
%     pp1_disc(:,itera)=p_d;
% end
%     P_calculada_RD_disc(:,i)=pp1_disc(:,end);
%     %P_calculada_RD_disc(:,i)=pp1_disc(:,end)*Pd(i);
% end

%% RD discretizados por euler

% for i=1:nh
% salir=1;
% T=0.01;
%
% p0 = zeros(1,n);           %Condiciones inciiales RD
% p_0 = 0.1.*rand(1,n-1);
% p0 = [1-sum(p_0) p_0];
% %p_d=p0*Pd(i);
% p_d=[0.5168 0.1657 0.2220 0.0955]*Pd(i);
% % p0=ones(1,n)/n*Pd(i);
% % p_d=p0;
%
% itera=0;
% while salir==1
%     itera=itera+1;
%     %fitness
%     for j=1:n
%        f_d(j)=r(j)*(1-p_d(j)/pn(j));
%        %f_d(j)=r(j)*(1-Pd(i)*p_d(j)/pn(j));
%        f_bari_d(j)=p_d(j)*f_d(j);
%     end
%     %fitness promedio
%     f_bar_d=1/Pd(i)*sum(f_bari_d);
%     %f_bar_d=sum(f_bari_d);
%     for j=1:n
%     pmas_d(j)=p_d(j)+T*(p_d(j)*(f_d(j)-f_bar_d));
%     end
%     %error
%     error=sum(abs(pmas_d-p_d))
%     %otro error
%     %error=abs(mean(f_d)-f_bar_d)
%
%     if error<1e-6
%         salir=0;
%     end
%     p_d=pmas_d;
%     pp1_disc(:,itera)=p_d;
% end
%     P_calculada_RD_disc_E(:,i)=pp1_disc(:,end);
%     %P_calculada_RD_disc(:,i)=pp1_disc(:,end)*Pd(i);
% end


%% graficación
figure
subplot(1,3,1)
plot(P_calculada_MBC2(1:4,:)','LineWidth',2);
pnominales=[ones(1,24)*p1;ones(1,24)*p2;ones(1,24)*p3;ones(1,24)*p4];
% hold on
% plot([1:24],pnominales*factor_demanda,'--')
grid
% subplot(1,3,2)
% plot(P_calculada_RD_disc','LineWidth',2)
% pnominales=[ones(1,24)*p1;ones(1,24)*p2;ones(1,24)*p3;ones(1,24)*p4];
% hold on
% plot([1:24],pnominales*factor_demanda,'--')
grid
subplot(1,3,3)
plot(P_calculada_RD','LineWidth',2)
% hold on
% plot([1:24],pnominales*factor_demanda,'--')
grid

%% comprobación de costos y demandas
P_RD=P_calculada_RD';
P_MBC1=P_calculada_MBC1;
%P_MBC2=P_calculada_MBC2(1:4,:);
P_demanda=Pd';
Suma_RD=sum(P_RD);
Suma_MBC1=sum(P_MBC1);
%Suma_MBC2=sum(P_MBC2);

% figure
% plot(Suma_MBC1,'--b')
% hold on
% plot(Suma_MBC2,'b')
% plot(Suma_RD,'r','linewidth',2)
% plot(P_demanda,'--k')
% plot(ones(1,24)*pmax,'--b')

%% confirmación de puntos de equilibrio
pcalc=pn-c'.*pn/prom_pond*(pmax-Pd(1,1))

%% datos importantes:
%potencia cubierta
P_cov_MBC=sum(P_calculada_MBC2(1:4,:))./Pd';
P_cov_RD=sum(P_calculada_RD)./Pd';

%costos totales
for i=1:4
    Costos_1(i,:)=P_calculada_MBC2(i,:)*c(i);
end
C_MBC=sum(Costos_1);
for i=1:4
    Costos_1(i,:)=P_calculada_RD(i,:)*c(i);
end
C_RD=sum(Costos_1);


%% graficación para journal paper
% tomado de conference paper grafication Rome (Dispatch)
% caso 1
pnominales=[ones(1,24)*p1;ones(1,24)*p2;ones(1,24)*p3;ones(1,24)*p4];

ancho=0.75; alto=0.82; izq=0.09; abajo=0.1;
scrsz = get(0,'ScreenSize');
figure('Position',[1 1 scrsz(3)/2.2 scrsz(4)/2])

ax1 = gca;
set(ax1,'Position',[izq,abajo,ancho,alto]);
plot(P_calculada_RD','k');
hold on
plot([1:24],pnominales*factor_demanda,'k')
axis([1 24 20 180])
ylabel('Power dispatched (kW)','fontsize',12)
title('MBC and RD Dispatch','fontsize',12,'FontWeight','bold')
xlabel('Hours','fontsize',12)
grid

%% caso 2 (graficas de los dos métodos)

ancho=0.75; alto=0.4; izq=0.09; abajo=0.55;
scrsz = get(0,'ScreenSize');
figure('Position',[1 1 scrsz(3)/2.2 scrsz(4)/1.6])

subplot(2,1,1)
ax1 = gca;
set(ax1,'Position',[izq,abajo,ancho,alto]);
plot(P_calculada_MBC2');
hold on
%plot([1:24],pnominales*factor_demanda,'--')
axis([1 24 -10 155])
ylabel('Power dispatched (kW)','fontsize',12)
title('MBC Dispatch','fontsize',12,'FontWeight','bold')
grid

subplot(2,1,2)
ax1 = gca;
set(ax1,'Position',[izq,abajo-0.48,ancho,alto]);
plot(P_calculada_RD');
hold on
%plot([1:24],pnominales*factor_demanda,'--')
axis([1 24 -10 155])
title('RD Dispatch','fontsize',12,'FontWeight','bold')
ylabel('Power dispatched (kW)','fontsize',12)
xlabel('Hours','fontsize',12)
grid

%% costs and coverage
ancho=0.38; alto=0.75; izq=0.1; abajo=0.15;
scrsz = get(0,'ScreenSize');
figure('Position',[1 1 scrsz(3)/2.1 scrsz(4)/3.8])

subplot(1,2,1)
ax1 = gca;
set(ax1,'Position',[izq,abajo-0,ancho,alto]);
plot(P_cov_MBC*100)
hold on
plot(P_cov_RD*100,'r')
ylabel('Covered demand (%)','fontsize',12)
xlabel('Hours','fontsize',12)
title('Coverage','fontsize',12,'FontWeight','bold')
axis([1 24 90 150])
grid

subplot(1,2,2)
ax1 = gca;
set(ax1,'Position',[izq+0.5,abajo-0,ancho,alto]);
plot(C_MBC)
hold on
plot(C_RD,'r')
ylabel('Costs (kW p.u.)','fontsize',12)
xlabel('Hours','fontsize',12)
title('Total Costs','fontsize',12,'FontWeight','bold')
axis([1 24 10 70])
grid

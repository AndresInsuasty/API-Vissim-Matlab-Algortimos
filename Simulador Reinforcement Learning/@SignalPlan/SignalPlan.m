%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%                        Universidad de los Andes                         %
%           Departamento de ingeniería Eléctrica y Electrónica            %
%    Grupo de Investigación en Automatización y para la producción GIAP   %
%                                                                         %
%               Urban Traffic Simulator VISSIM - MATLAB                   %
%                                                                         %
%         By: Iván Felipe Gutiérrez Delgado & Pablo Ñañez Ojeda           %
%                                                                         %
%       This is class calculate the Signal Plan with the green times and  %
%                 other info defined by the properties                    %
%                                                                         %
%    First revision: March 25 / 2013                                      %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SpDB{i,j,k,l}: Signal plan Data Base.
% Spx = GetSp(inGreen,minTao,TC,orden);
% SpX{q,c,1} = Spx{1};
% SpX{q,c,2} = Spx{2};
% q) Signal plan
% c) Controller
% k = 1) Signal state matrix (signal groups x number of states)
% k = 2) Time vector
% Case 1
% orden{signalGroup} = (phases) [1 2 4 5] - (RA V A R)
% minTao Case 1 (1 2 4 5 - RA V A R)
% minTao{signalGroup} = [minRA TV minAmb -1]
% Case 2
% orden{signalGroup} = (phases) [2 3 5] - (V Vint R)
% minTao Case 2 (2 3 5 - V Vint R)
% minTao{signalGroup} = [TV minVint -1]



classdef SignalPlan

    properties
        
        % The properties are cells and contains the info about all
        % controller of the network.
        
        % Number of signal groups
        nsg
        
        % Cycle time
        cycle
        
        % order for each signal group
        order
        
        % Minimun time for begin each light 
        minTao
        
        %Red-yellow time (From red to green)
        RATime
        
        %Yellow time (from green to red)
        yellowTime
        
    end
    
    
    methods
        
    % Constructor of this class 
        function obj = SignalPlan(n_s_g, cycle_time,order_p, minTao_p,RAtime,yellow_t)
        
            obj.nsg = n_s_g;
            obj.cycle = cycle_time;
            obj.order = order_p;
            obj.minTao = minTao_p;
            obj.RATime = RAtime;
            obj.yellowTime = yellow_t;
                        
        end
        

% Getters for all properties of this class
       
                function res = get_RATime(obj)
            
                    res = obj.RATime;
            
            
                end
        
                
                function res = get_nsg(obj)
            
                    res = obj.nsg;
            
            
                end
                
                function res = get_yellowTime(obj)
            
                    res = obj.yellowTime;
            
            
                end
        
                function res = get_cycle(obj)
            
                    res = obj.cycle;
            
            
                end
                function res = get_order(obj)
            
                     res = obj.order;
            
            
                end
                function res = get_minTao(obj)
            
                    res = obj.minTao;
            
            
                end
                
% Setters for all properties of this class
                function obj = set_cycle(obj, property_value )
                    
                    obj.cycle = property_value;
                    
                end
                
                function obj = set_RATime(obj, property_value )
                    
                    obj.RATime = property_value;
                    
                end
                                
                function obj = set_yellowTime(obj, property_value )
                    
                    obj.yellowTime = property_value;
                    
                end
                
                
                function obj = set_nsg(obj, property_value )
                    
                    obj.nsg = property_value;
                
                end
                
                function obj = set_order(obj, property_value )
                    
                    obj.order = property_value;
                
                end
                
                function obj = set_minTao(obj, property_value )
                    
                    obj.minTao = property_value;
                
                end
                
    % Calculate the signal plan (By Pablo Ñañez Ojeda)
    function Sp = GetSp(obj,inGreen,minTao,C,orden)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Matlab M-file                Author:Pablo Ñañez
    %
    % Project: Traffic simulation
    %
    % Name: GetSp.m
    %
    %
    % Version: 0.1
    % Required files: -
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % constants
    % minTao Case 1 (phases 1 2 4 5 - RA V A R)
    % minTao{phase}([]) = [minRA TV minAmb -1]
    % minTao Case 2 (phases 2 3 5 - V Vint R)
    % minTao{phase}([]) = [TV minVint -1]
    Sp1 = zeros (length(inGreen),C);
    for iph = 1:length(inGreen)
        Sp1 = circshift(Sp1,[0 -(inGreen(iph)-1)]);
        minTao{iph}(end) = C - sum(minTao{iph}(1:end-1));
        it = 1;
        for iSp = 1:length(minTao{iph})
            Sp1(iph,it:it-1+minTao{iph}(iSp))= orden{iph}(iSp); % state
            it = it+minTao{iph}(iSp);
        end
        Sp1 = circshift(Sp1,[0 +(inGreen(iph)-1)]);
    end
    Sp2 = [];
    Sp{1}(:,1) = Sp1(:,1);
    Sp{2}(1) = 2;
    for it = 1:C-1;
        if sum(Sp1(:,it)==Sp1(:,it+1))==length(inGreen)
            Sp{1}(:,end) = Sp1(:,it);
            Sp{2}(end) = Sp{2}(end)+1;
        else
            Sp{1}(:,end+1) = Sp1(:,it+1);
            Sp{2}(end+1) = 1;
        end
    end
    Sp{2}(end) = Sp{2}(end)-1;

    end
    
   
  % This function draw the signal plan calculated Autor: Pablo Ñañez  
    function obj = DrawSignalPlan(obj,SpX,FigIn,controlers)
in = nargin;

% nsg: Number of signal groups
% mp: Number of phases in each signal plan
% nSP: Number of signal plans to measure
% nc: Number of controlers
global z0 x0 u0 T J m n uu Sp rule qsw;
%global Sp;
in = nargin;

Jspan = 200;
J = Jspan;
JSPAN = [0 Jspan];

[nSP nc n2] = size(SpX);
nc = length(controlers);
ifig = 1;
% for iSP = 1:nSP
    for ic = 1:nc
        if in==1
            figure(ifig);
        elseif in>=2
            figure(FigIn)
        end
        clf        
        ifig = ifig+1;
        Sp{1,1} = SpX{controlers(ic).q,controlers(ic).idController,1};
        Sp{1,2} = SpX{controlers(ic).q,controlers(ic).idController,2};
        iniSp = 1;
        T = sum(Sp{1,2})-0;
        TSPAN = [0 sum(Sp{1,2})];
        
        xini = Sp{iniSp,1}(:,iniSp);
        
        x0 = [0;controlers(ic).q;1;xini;0];
        u0 = [0;controlers(ic).q;1;xini;0];
        uu = u0';
        z0 = [x0; u0];
        n = length(x0); %# of state components
        m = length(u0); %# of input components
        
        % simulation horizon
        % rule for jumps
        % rule = 1 -> priority for jumps
        % rule = 2 -> priority for flows
        % rule = 3 -> no priority, random selection when simultaneous conditions
        rule = 1;
        % constants
        %global  m n;
        n = length(x0); %# of state components
        m = length(u0); %# of input components
        %% simulate
        try
            [t x j] = hybridsolver(@f,@g,@C,@D,z0,TSPAN,JSPAN,rule);
        catch ME
        end
        %%
        % plot solution
        x = squeeze(x);
        subplot(2,1,1),plot(t,x(:,1))
        grid on
        str = sprintf('Evolution of the internal clock of the IMATIC controller. SP#%d',controlers(ic).q);
        title(str)
        xlabel('time')
        ylabel('\tau')
        subplot(2,1,2), hold on
        for ij=0:1:j(end)
            iij = find(j==ij,1,'first');
            fij = find(j==ij,1,'last');
            for iph = 1:length(x0)-4;
                switch x(iij,3+iph)
                    case 1 % RA
                        plot([t(iij),t(fij)],[iph,iph],'--y','LineWidth',4)
                        plot([t(iij),t(fij)],[iph+(0.1),iph+(0.1)],'--r','LineWidth',4)
                    case 2 % V
                        plot([t(iij),t(fij)],[iph,iph],'g','LineWidth',4)
                    case 3 % Vint
                        plot([t(iij),t(fij)],[iph,iph],'--g','LineWidth',4)
                        plot([t(iij),t(fij)],[iph+(0.1),iph+(0.1)],'--k','LineWidth',4)
                    case 4 % RA
                        plot([t(iij),t(fij)],[iph,iph],'y','LineWidth',4)
                    case 5 % RA
                        plot([t(iij),t(fij)],[iph,iph],'r','LineWidth',4)
                end
            end          
        end
        if in == 3
            taoTotal = sum(controlers(ic).SP{2}(1:controlers(ic).sigma-1));
            ytaoVec = (controlers(ic).tao+taoTotal).*ones(1,2);
            xtaoVec = [0 iph];
            plot(ytaoVec,xtaoVec,'k')
        end
        drawnow
    end
    
% end
    end
    end
end
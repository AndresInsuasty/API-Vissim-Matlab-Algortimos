classdef HybridController
    % HybridController developed by Pablo Ñañez
    % Simulated IMATIC traffic controller!
    properties
        SpDB = {}; % Signal plan Database {i}{j} i) plan j=1 states j=2 times
        idController = 1; % Controller identification
        SP = {}; % Signal plan
        Sensors = {};
        nsg = 0; % Number of signal groups
        nphs = 0; % Number of signal phases
        tao = 0; % Internal clock
        q   = 1; % Current plan in execution
        sigma = 1; % Current phase of the plan
        state; % state of the signal groups
        T = 0;
        VissimNet; % VISSIM network object
    end
    methods
        function obj = HybridController(Spin,id,SensorsIn,qin,sigmain) % Creator
            in = nargin;
            switch in
                case 0
                case 1
                    obj.SpDB = Spin;
                case 2
                    obj.SpDB = Spin;
                    obj.idController = id;
                case 3
                    obj.SpDB = Spin;
                    obj.idController = id;
                    obj.Sensors = SensorsIn;
                case 4
                    obj.SpDB = Spin;
                    obj.idController = id;
                    obj.Sensors = SensorsIn;
                    obj.q = qin;
                case 5
                    obj.SpDB = Spin;
                    obj.idController = id;
                    obj.Sensors = SensorsIn;
                    obj.q = qin;
                    obj.sigma = sigmain;
            end
            
            obj.SP{1} = obj.SpDB{obj.q,obj.idController,1};
            obj.SP{2} = obj.SpDB{obj.q,obj.idController,2};
            [obj.nsg obj.nphs] = size(obj.SpDB{1,obj.idController,1});
        end
        function obj = set.state(obj,State)
            obj.state = State;
        end
        function obj = set.q(obj,qin)
            obj.q = qin;
            obj.SP{1} = obj.SpDB{obj.q,obj.idController,1};
            obj.SP{2} = obj.SpDB{obj.q,obj.idController,2};
        end
        
% *************************************************************************        
% *************************************************************************
        function [obj x t j ID] = simIMATICControl(obj,...
                vissimOBJ,drawFig,tin,tfin,Jspan,U)
            global z0 x0 u0 T J m n uu Sp rule qsw SPDB idCont;
            % simulation horizon
            T = tfin-tin;
            TSPAN = [tin tfin];
            J = Jspan;
            JSPAN = [0 Jspan];
            % Índice de desempeño
            ID = zeros(obj.nsg,1);
            for isg = 1:length(obj.Sensors)
                if obj.Sensors{isg}~=0
                    %                     ID(isg) = obj.Sensors{isg}.GetResult(tin, 'STOPS');
                                        ID(isg) =obj.Sensors{isg}.AttValue('QStops(Current,Current)');
                    %                     ID(isg) = obj.Sensors{isg}.GetResult(tin, 'MEAN');
%                     ID(isg) = obj.Sensors{isg}.GetResult(tin, 'MAX');
                end
            end
            % rule for jumps
            % rule = 1 -> priority for jumps
            % rule = 2 -> priority for flows
            % rule = 3 -> no priority, random selection when simultaneous conditions
            rule = 1;
            in = nargin;
            switch in
                case 6
                    obj.SP{1} = obj.SpDB{obj.q,obj.idController,1};
                    obj.SP{2} = obj.SpDB{obj.q,obj.idController,2};
                    if isempty(obj.state)
                        xini = obj.SP{1}(:,obj.q);
                    else
                        xini = obj.state;
                    end
                    % combine initial conditions
                    % x0 = [tao;q;sigma;x0;delta];
                    % u0 = [tao_u;q_u;sigma_u;x0_u;delta];
                    x0 = [obj.tao;obj.q;obj.sigma;xini;0];
                    % HERE IS THE CONTROL!!!!
                    u0 = [obj.tao;obj.q;obj.sigma;xini;0];
                    uu = u0';
                    z0 = [x0; u0];
                    n = length(x0); %# of state components
                    m = length(u0); %# of input components
                    Sp = obj.SP;
                    SPDB = obj.SpDB;
                    idCont = obj.idController;
                    qsw = obj.q;
                    [t x j] = hybridsolver( @f,@g,@C,@D,z0,TSPAN,JSPAN,rule);
                    %                     sim('HybridSimulatorIMATIC');
                    x = squeeze(x);
                    obj.state = x(end,4:3+obj.nsg)';
                    obj.tao = x(end,1)';
                    obj.q = x(end,2)';
                    obj.sigma = x(end,3)';
                case 7
%                     obj.q = U;
%                     obj.SP{1} = obj.SpDB{obj.q,obj.idController,1};
%                     obj.SP{2} = obj.SpDB{obj.q,obj.idController,2};
                    obj.SP{1} = obj.SpDB{obj.q,obj.idController,1};
                    obj.SP{2} = obj.SpDB{obj.q,obj.idController,2};
                    if isempty(obj.state)
                        xini = obj.SP{1}(:,obj.q);
                    else
                        xini = obj.state;
                    end
                    % combine initial conditions
                    % x0 = [tao;q;sigma;x0;delta];
                    % u0 = [tao_u;q_u;sigma_u;x0_u;delta];
                    x0 = [obj.tao;obj.q;obj.sigma;xini;0];
                    % HERE IS THE CONTROL!!!!
                    u0 = [0;U;obj.sigma;xini;0];
                    uu = u0';
                    z0 = [x0; u0];
                    n = length(x0); %# of state components
                    m = length(u0); %# of input components
                    Sp = obj.SP;
                    qsw = obj.q;
                    [t x j] = hybridsolver( @f,@g,@C,@D,z0,TSPAN,JSPAN,rule);
                    %                     sim('HybridSimulatorIMATIC');
                    x = squeeze(x);
                    obj.state = x(end,4:3+obj.nsg)';
                    obj.tao = x(end,1)';
                    obj.q = x(end,2)';
                    obj.sigma = x(end,3)';
            end
            %if drawFig
                % plot solution
                obj.VissimNet = vissimOBJ;
                for iph = 1:length(x0)-4;
                    %labelGroup{iph} = obj.VissimNet.Net.SignalControllers.ItemByKey(obj.idController).SGs.ItemByKey(iph).Name;
                    labelGroup{iph} = obj.VissimNet.Net.SignalControllers.ItemByKey(obj.idController).SGs.ItemByKey(iph).AttValue('Name');
                    tickGroup(iph) = iph;
                end
                figure1 = figure(1);
                clf;
                subplot2 = subplot(2,1,2,'Parent',figure1,...
                    'YTickLabel',labelGroup,...
                    'YTick',tickGroup);
                hold on;
                hold(subplot2,'all');
                subplot(2,1,1),plot(t,x(:,1))
                grid on
                title(['Evolution of the internal clock of the IMATIC controller'])
                xlabel('time')
                ylabel('\tau')
                subplot(2,1,2)
                for ij=0:1:j(end)
                    iij = find(j==ij,1,'first');
                    fij = find(j==ij,1,'last');
                    for iph = 1:length(x0)-4;
                        switch x(iij,3+iph)
                            case 1 % RA
                                plot([t(iij),t(fij)],[iph,iph],'--y','LineWidth',4,'Parent',subplot2)
                                plot([t(iij),t(fij)],[iph+(0.1),iph+(0.1)],'--r','LineWidth',4,'Parent',subplot2)
                            case 2 % V
                                plot([t(iij),t(fij)],[iph,iph],'g','LineWidth',4,'Parent',subplot2)
                            case 3 % Vint
                                plot([t(iij),t(fij)],[iph,iph],'--g','LineWidth',4,'Parent',subplot2)
                                plot([t(iij),t(fij)],[iph+(0.1),iph+(0.1)],'--k','LineWidth',4,'Parent',subplot2)
                            case 4 % Y
                                plot([t(iij),t(fij)],[iph,iph],'y','LineWidth',4,'Parent',subplot2)
                            case 5 % R
                                plot([t(iij),t(fij)],[iph,iph],'r','LineWidth',4,'Parent',subplot2)
                        end
                    end
                    drawnow
                end
            %end
        end
    end
end
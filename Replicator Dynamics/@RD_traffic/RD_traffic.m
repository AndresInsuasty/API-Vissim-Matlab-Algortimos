classdef RD_traffic
    % Hybrid Replicator Dynamics Controller by Pablo ?a?ez
    properties
        SpDB = {}; % Signal plan Database {i}{j} i) plan j=1 states j=2 times
        idController = 1; % RD Controller identification
        controlers = []; % Signal controlers (field controlers)
        U_phases = []; % Controlled phases in the Signal Plan
        RDHdae = []; % Hybrid Dae Replicator Dynamics object
        NStr = 0; % Number of strategies for the RD object
        P = 1; % Total Resource to be distributed
        RDID = 0; % Performance index for the entire system
        a = []; % Vector of measurements (profitability)
    end
    properties (SetAccess = private, Hidden = true)
        sA = []; % Sum of all benefits in all strategies
        a_t = []; % Time vector of benefits
        H = []; % Time horizon to get the ID
        E = []; % DAE matrix
        A = []; % DAE matrix
        B = []; % DAE matrix
        Q = []; % HDae data
    end
    methods
        function obj = RD_traffic(Spin,id,controlersIn,Pin,U_in) % Creator
            obj.SpDB = Spin;
            obj.idController = id;
            obj.controlers = controlersIn;
            obj.U_phases = U_in;
            obj.P = Pin;
            for ic = 1:length(obj.controlers)
                for isen = 1:length(obj.controlers(ic).Sensors)
                    if obj.controlers(ic).Sensors{isen}~=0
                        obj.NStr = obj.NStr+1;
                    end
                end
            end
            obj.a = ones(obj.NStr,1);
            obj.H = 15;
            obj  = calculateProperties(obj);
            
        end
        function obj = calculateProperties(obj)
            obj.sA = sum(obj.a);
            obj.E = eye(obj.NStr);
            obj.E(obj.NStr+1,obj.NStr+1) = 0;
            obj.A = -obj.sA/obj.P.*eye(obj.NStr);
            obj.A(obj.NStr+1,1:obj.NStr+1) = [ones(1,obj.NStr) -1];
            obj.B(1:obj.NStr+1,1) = [obj.a;0];
            obj.Q = [1];
            obj.RDHdae = Hdae(obj.Q,@C_RD,@D_RD,@Csigma,obj.E,...
                obj.A,@G_RD,obj.B);
        end
        function [obj] = simRD(obj,TSPAN,ID)
            ia = 1;
            for ic = 1:length(obj.controlers)
                for isen = 1:length(obj.controlers(ic).Sensors)
                    if obj.controlers(ic).Sensors{isen}~=0
                        obj.a(ia) = ID(ia);
                        ia = ia + 1;
                    end
                end
            end
            sa_t = size(obj.a_t);        
            if sa_t(2) < obj.H
                obj.a_t(:,end+1) = ID; 
            else
                obj.a_t = circshift(obj.a_t,[0 -1]);
                obj.a_t(:,end) = ID;
            end
            obj  = calculateProperties(obj);
            obj  = getID(obj);
            % simulation horizon
            J = 100;
            JSPAN = [0 J];
            if isempty(obj.RDHdae.state)
                obj.RDHdae.state = [obj.P/obj.NStr.*ones(1,obj.NStr) obj.P 1];
            else
            end
            [obj.RDHdae x t j] = obj.RDHdae.simulate(TSPAN,JSPAN,obj.RDHdae.state,1);
            iPh = 1;
            for ic = 1:length(obj.controlers)
                for isen = 1:length(obj.controlers(ic).Sensors)
                    if obj.controlers(ic).Sensors{isen}~=0
                        obj.controlers(ic).SP{:,2}(obj.U_phases(iPh)) = max(1,obj.RDHdae.state(iPh));
                        obj.SpDB{obj.controlers(ic).q,obj.controlers(ic).idController,2}(obj.U_phases(iPh)) = max(1,round(obj.RDHdae.state(iPh)));
                        iPh = iPh + 1;
                    end
                end
            end
        end
        function [obj] = getID(obj)
            try
                obj.RDID = mean(mean(obj.a_t));
            catch
                obj.RDID = 0;
            end
        end
    end
end


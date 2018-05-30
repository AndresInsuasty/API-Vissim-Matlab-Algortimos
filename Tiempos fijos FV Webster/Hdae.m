%% -------------------------------------------------------------------------
% Hdae.m
% -------------------------------------------------------------------------
% Hybrid Differential Algebraic Equation System simulation engine
% By Pablo ?a?ez
% Based on the work of R. Sanfelice and Stephan Trenn
% Universidad de los Andes
% Bogot?, Colombia
% March 2012
% -------------------------------------------------------------------------

%% -------------------------------------------------------------------------
% VARIABLE NAMES AND EXPLICATION
% -------------------------------------------------------------------------
classdef Hdae
    properties
        Q = [1]; % Set of nominal configurations (configuration index)
        C = []; % Set of flow sets (as a Matlab function)
        D = []; % Set of jump sets (as a Matlab function)
        Csigma = []; % Consistency space, or Set of consistency sets
        E = []; % System matrix set E_sigma\dot{x} = A_sigma x + B_sigma
        A = []; % System matrix set E_sigma\dot{x} = A_sigma x + B_sigma
        B = []; % System matrix set E_sigma\dot{x} = A_sigma x + B_sigma
        G = []; % Set of set valued functions (as a Matlab function)
        sigma = 1; % Active configuration
        state = []; % State of the system;
        n = 0; % Number of states
        Cea = []; % Consistency spaces for each nominal configuration (NC)
        Pi = []; % Consistency projector for each NC
        isRegular = []; % Regularity of each NC 1 - Regular \ 0 - No Regular
        T = []; % Matrix T
        J = []; % Matrix J
        N = []; % Matrix N
    end
    methods
        function obj = Hdae(Qin,Cin,Din,Csigmain,Ein,Ain,Gin,Bin) % Creator
            in = nargin;
            switch in
                case 7
                    obj.Q = Qin;
                    obj.C = Cin;
                    obj.D = Din;
                    obj.Csigma = Csigmain;
                    obj.E = Ein;
                    obj.A = Ain;
                    obj.G = Gin;
                case 8
                    obj.Q = Qin;
                    obj.C = Cin;
                    obj.D = Din;
                    obj.Csigma = Csigmain;
                    obj.E = Ein;
                    obj.A = Ain;
                    obj.G = Gin;
                    obj.B = Bin;
                otherwise
                    error('Hdae:argNumChk', 'Wrong number of input arguments')
            end
            obj = obj.CalculateProperties(0);
        end
        function [obj] = CalculateProperties(obj,draw)
            in = nargin;
            if in == 1
                draw = 0;
            end
            nn = size(obj.E);
            nna = size(obj.A);
            nnb = size(obj.B);
            if obj.n ~= nn(1)
                for iDAE = 1:length(obj.Q)
                    obj.E(nn(1)+1,nn(1)+1,iDAE) = 1; % add the sigma dimension \dot{sigma} = 0
                end
                nn = size(obj.E);
            end
            if obj.n ~= nna(1)
                for iDAE = 1:length(obj.Q)
                    obj.A(nna(1)+1,nna(1)+1,iDAE) = 0;
                end
                nna = size(obj.A);
            end
            if obj.n ~= nnb(1)
                for iDAE = 1:length(obj.Q)
                    obj.B(nnb(1)+1,iDAE) = 0;
                end
                nnb = size(obj.B);
            end
            if (nn(1)==nna(1)&&nna(1)==nnb(1))~=1
                fprintf('Problems with size dimentions in Hdae\n')
            end
            obj.n = nn(1);
            
            warning('off','MATLAB:singularMatrix')
            warning('off','MATLAB:rankDeficientMatrix')
            nn = size(obj.E);
            try
                nDAEs = nn(3);
            catch
                nDAEs = 1;
            end
            obj.n = nn(1);
            obj.isRegular = zeros(nDAEs,1);
            for iDAE = 1:nDAEs
                %                 fprintf('Calculating E%d and A%d \n',iDAE,iDAE)
                [obj.isRegular(iDAE)] = isDAEregular(obj.E(:,:,iDAE),obj.A(:,:,iDAE));
            end
            %% Consistency spaces for each DAE system
            clear symengine;
            obj.Pi = zeros(obj.n,obj.n,nDAEs);
            obj.Cea{nDAEs} = [];
            obj.T{nDAEs} = [];
            Ep = sym(obj.E);
            Ap = sym(obj.A);
            arrDAE = find(obj.isRegular,length(obj.isRegular),'first');
            for iDAE = arrDAE'
%                 fprintf('Calculating consistency spaces and consistency projectors Pi_%d \n',iDAE)
                %     clear symengine;
                V = getVspace(Ep(:,:,iDAE),Ap(:,:,iDAE));
                W = getWspace(Ep(:,:,iDAE),Ap(:,:,iDAE));
                Ti = [V,W];
                [obj.n,n1] = size(V);
                [obj.n,n2] = size(W);
                obj.Cea{iDAE} = double(V);
                obj.T{iDAE} = double(Ti);
                obj.Pi(:,:,iDAE) = obj.T{iDAE}*diag([ones(1,n1), zeros(1,n2)])/(obj.T{iDAE});
                %     polCar = det(s*Ep(:,:,iDAE)- Ap(:,:,iDAE));
                obj.J{iDAE} = double(Ap(:,:,iDAE)*V)\(double(Ep(:,:,iDAE)*V));
                obj.N{iDAE} = double(Ep(:,:,iDAE)*W)\(double(Ap(:,:,iDAE)*W));
            end
            Ep = double(Ep);
            Ap = double(Ap);
            Assumption1 = -ones(nDAEs,1);
            Assumption2 = -ones(nDAEs);
            Assumption3 = -ones(nDAEs);
            for pDAE = arrDAE'
                MAssumption1 = Ep(:,:,iDAE)*(eye(obj.n)-obj.Pi(:,:,iDAE));
                Assumption1(pDAE) = sum(sum(MAssumption1 ~= zeros(obj.n)))==0;
                for qDAE = arrDAE'
%                     fprintf('Assumptions A2 and A3 for E_%d and E_%d\n',pDAE,qDAE)
                    clear symengine;
                    MAssumption2 = Ep(:,:,pDAE)*(eye(obj.n)-obj.Pi(:,:,pDAE))*obj.Pi(:,:,qDAE);
                    Assumption2(pDAE,qDAE) = sum(sum(MAssumption2 ~= zeros(obj.n)))==0;
                    MAssumption3 = (eye(obj.n)-obj.Pi(:,:,pDAE))*obj.Pi(:,:,qDAE);
                    Assumption3(pDAE,qDAE) = sum(sum(MAssumption3 ~= zeros(obj.n)))==0;
                end
            end
            %             Assumption1
            %             Assumption2
            %             Assumption3
            ImpulsiveMatrix = Assumption2+Assumption3;
            ImpulsiveMatrix(ImpulsiveMatrix==2) = 1;
            ImpulsiveMatrix(ImpulsiveMatrix==-2) = -1;
            %% Plots
            if draw==1
                IM = ImpulsiveMatrix;
                IM(end+1,end+1) = 0;
                pcolor(IM');
                colormap(gray(2))
                axis ij
                axis square
            end
            warning('on','MATLAB:singularMatrix')
            warning('on','MATLAB:rankDeficientMatrix')            
        end
        function [obj x t j] = simulate(obj, Tspan, Jmax, x0, rule)
            if ~exist('rule','var')
                Rule = 2;
            else
                Rule = rule;
            end
            warning('off','MATLAB:singularMatrix')
            [obj t x j] = hybridsolverDAE(obj,x0,Tspan,Jmax,Rule);
            warning('on','MATLAB:singularMatrix')
        end
    end
end


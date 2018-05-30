classdef UTNSimulation
    % UTNSimulation, Urban Traffic Network simulation
    % developed by Pablo Ñañez
    % Simulated IMATIC traffic controller and UTN
    properties
        VissimNet = []; % VISSIM network object
        Controllers = []; % Controllers HybridController objects
        SpDB = {}; % Signal plan Database {i}{j} i) plan j=1 states j=2 times
        tao = 0; % Internal clock
        t = 0; % time vector
    end
    methods
        function obj = UTNSimulation(vissimOBJ,ControllerArr,SpDBin) % Creator
            obj.VissimNet = vissimOBJ;
            obj.Controllers = ControllerArr;
            obj.SpDB = SpDBin;
        end
        function [obj ID stateOut ti] = simNetwork(obj,drawFig,tfin,Jspan,U)
            global z0 x0 u0 T J m n uu Sp rule;
            ti(1) = obj.VissimNet.simulation.AttValue('SimSec');
            for icontr = 1:length(obj.Controllers)
                ID{icontr}(:,1) = zeros(length(obj.Controllers(icontr).Sensors),1);
                try
                    [obj.Controllers(icontr) x t j ID{icontr}(:,length(ti))] =...
                        obj.Controllers(icontr).simIMATICControl(...
                        obj.VissimNet,drawFig,ti(end),ti(end),Jspan);
                catch
                end
            end
            i = 1;
            while ti(end)<tfin
                obj.VissimNet.simulation.RunSingleStep
                ti(end+1) = obj.VissimNet.simulation.AttValue('SimSec');
 %               global z0 x0 u0 T J m n uu Sp rule;
                tin = ti(end-1);
                tend = ti(end);
                for icontr = 1:length(obj.Controllers)
                    %                     [obj.Controllers(icontr) x t j ID{icontr}(:,length(ti))] =...
                    %                         obj.Controllers(icontr).simIMATICControl(...
                    %                         obj.VissimNet,drawFig,tin,tend,Jspan);
                    [ControllersX(icontr) x t j ID{icontr}(:,length(ti))] =...
                        obj.Controllers(icontr).simIMATICControl(...
                        obj.VissimNet,drawFig,tin,tend,Jspan);
                    if isempty(obj.Controllers(icontr).state)
                        obj.Controllers(icontr) = ControllersX(icontr);
                    end
                    
                    for igroup = 1:obj.Controllers(icontr).nsg
                        groupStatePast = obj.Controllers(icontr).state(igroup);
                        groupState     = ControllersX(icontr).state(igroup);
                        if groupStatePast ~= groupState
                            switch groupState % Group igroup
                                case 1 % RA (2)
                                    obj.VissimNet.Net.SignalControllers. ...
                                        ItemByKey(icontr). ...
                                        SGs.ItemByKey(igroup). ...
                                        set('AttValue', 'State', 2);

                                case 2 % V  (3)
                                    obj.VissimNet.Net.SignalControllers. ...
                                        ItemByKey(icontr). ...
                                        SGs.ItemByKey(igroup). ...
                                        set('AttValue', 'State', 3);
                                case 3 % FV (10)
                                    obj.VissimNet.Net.SignalControllers. ...
                                        ItemByKey(icontr). ...
                                        SGs.ItemByKey(igroup). ...
                                        set('AttValue', 'State', 10);
                                case 4 % Y  (4)
                                    obj.VissimNet.Net.SignalControllers. ...
                                       ItemByKey(icontr). ...
                                        SGs.ItemByKey(igroup). ...
                                        set('AttValue', 'State', 4);
                                case 5 % R  (1)
                                    obj.VissimNet.Net.SignalControllers. ...
                                        ItemByKey(icontr). ...
                                        SGs.ItemByKey(igroup). ...
                                        set('AttValue', 'State', 1);
                            end
                        end
                    end
                    obj.Controllers(icontr) = ControllersX(icontr);                    
                end
            end
            stateOut = 0;
        end
    end
end


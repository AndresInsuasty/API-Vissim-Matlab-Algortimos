%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%                        Universidad de los Andes                         %
%           Departamento de ingenier�a El�ctrica y Electr�nica            %
%    Grupo de Investigaci�n en Automatizaci�n y para la producci�n GIAP   %
%                                                                         %
%               Urban Traffic Simulator VISSIM - MATLAB                   %
%                                                                         %
%                By: Iv�n Felipe Guti�rrez Delgado                        %
%                                                                         %
%    This class is an comfortable inteface between the VISSIM PTV COM     %
%                         methods and Matlab Scripts.                     %
%                                                                         %
%    First revision: March 5 / 2013                                       %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef COMInterfaceVISSIM
    
    
    
    properties
        
        
        %TODO: Documentar las propiedades de acuerdo al manual VISSIM COM 540
        Vissim;
        VissimVersion;
        nControllers;
        nLinks;
        Net;
        Links;
        Link;
        Nodes;
        Node;
        ParkingLots;
        ParkingLot;
        Paths;
        Path;
        DrivingBehaviorParSets;
        TrafficCompositions;
        TrafficComposition;
        VehicleImputs;
        VehicleImput;
        Vehicles;
        Vehicle;
        RoutingDecisions;
        RoutingDecision;
        Routes;
        Route;
        DesiredSpeedDecisions;
        DesiredSpeedDecision;
        ReducedSpeedAreas;
        ReducedSpeedArea;
        StopSigns;
        StopSign;
        StaticObjects;
        StaticObject;
        SignalControllers;
        SignalController;
        Detectors;
        Detector;
        SignalGroups;
        SignalGroup;
        SignalHeads;
        SignalHead;
        
        
    end
    
    methods
        
        %creator of class
        function obj = COMInterfaceVISSIM( version,FileName,LayoutName,PathName)
            
            %32 bits versions
            if     (strcmp(version,'430.32'))
                ver = 'VISSIM.vissim-32.1';
                
            elseif (strcmp(version,'500.32'))
                ver = 'VISSIM.vissim-32.500';
                
            elseif (strcmp(version,'510.32'))
                ver = 'VISSIM.vissim-32.510';
                
            elseif (strcmp(version,'520.32'))
                ver = 'VISSIM.vissim-32.520';
                
            elseif (strcmp(version,'530.32'))
                ver = 'VISSIM.vissim-32.530';
                
            elseif (strcmp(version,'540.32'))
                ver = 'VISSIM.vissim-32.540';
                
                
                %64 bits versions
            elseif (strcmp(version,'100.64'))
                ver = 'VISSIM.vissim-64.100';
                
            elseif (strcmp(version,'500.64'))
                ver = 'VISSIM.vissim-64.500';
                
            elseif (strcmp(version,'510.64'))
                ver = 'VISSIM.vissim-64.510';
                
            elseif (strcmp(version,'520.64'))
                ver = 'VISSIM.vissim-32.520';
                
            elseif (strcmp(version,'530.64'))
                ver = 'VISSIM.vissim-64.530';
                
            elseif (strcmp(version,'540.64'))
                ver = 'VISSIM.vissim-64.540';
                
            end
            
            
            try
                
                
                obj.Vissim = actxserver(ver);
%                 if obj.Vissim.simulation.AttValue('ELAPSEDTIME') > 0
%                     obj.Vissim.Simulation.Stop   % Stop a simulation first
%                 end
                
                obj.Vissim.LoadNet([PathName,FileName]);
                obj.Vissim.LoadLayout([PathName,LayoutName]);
                
                
                % Now I read all the properties from instance and assign
                % it to the class properties
                
            catch
                msgbox('Aseg�rese de tener la licencia adecuada y la versi�n de VISSIM que ha seleccionado instalada','No fue posible abrir VISSIM','error')
            end
            
            obj.VissimVersion = version;
            
            
            
        end
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Setters methods
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %setter for Vissim Property
        function obj = set_Vissim(obj,property_value)
            
            obj.Vissim = property_value;
            
        end
        
        %setter for VissimVersion Property
        function obj = set_VissimVersion(obj,property_value)
            
            obj.VissimVersion = property_value;
            
        end
        
        
        %setter for nControllers Property
        function obj = set_nControllers(obj,property_value)
            
            obj.nControllers = property_value;
            
        end
        
        
        %setter for nLinks Property
        function obj = set_nLinks(obj,property_value)
            
            obj.nLinks = property_value;
            
        end
        
        
        %setter for Net Property
        function obj = set_Net(obj,property_value)
            
            obj.Net = property_value;
            
        end
        
        
        %setter for Links Property
        function obj = set_Links(obj,property_value)
            
            obj.Links = property_value;
            
        end
        
        
        %setter for Link Property
        function obj = set_Link(obj,property_value)
            
            obj.Link = property_value;
            
        end
        
        
        %setter for Nodes Property
        function obj = set_Nodes(obj,property_value)
            
            obj.Nodes = property_value;
            
        end
        
        
        %setter for Node Property
        function obj = set_Node(obj,property_value)
            
            obj.Node = property_value;
            
        end
        
        
        %setter for ParkingLots Property
        function obj = set_ParkingLots(obj,property_value)
            
            obj.ParkingLots = property_value;
            
        end
        
        
        %setter for ParkingLot Property
        function obj = set_ParkingLot(obj,property_value)
            
            obj.ParkingLot = property_value;
            
        end
        
        
        %setter for Paths Property
        function obj = set_Paths(obj,property_value)
            
            obj.Paths = property_value;
            
        end
        
        
        %setter for Path Property
        function obj = set_Path(obj,property_value)
            
            obj.Path = property_value;
            
        end
        
        
        %setter for DrivingBehaviorParSets Property
        function obj = set_DrivingBehaviorParSets(obj,property_value)
            
            obj.DrivingBehaviorParSets = property_value;
            
        end
        
        
        %setter for TrafficCompositions Property
        function obj = set_TrafficCompositions(obj,property_value)
            
            obj.TrafficCompositions = property_value;
            
        end
        
        
        %setter for TrafficComposition Property
        function obj = set_TrafficComposition(obj,property_value)
            
            obj.TrafficComposition = property_value;
            
        end
        
        
        %setter for VehicleImputs Property
        function obj = set_VehicleImputs(obj,property_value)
            
            obj.VehicleImputs = property_value;
            
        end
        
        
        %setter for VehicleImput Property
        function obj = set_VehicleImput(obj,property_value)
            
            obj.VehicleImput = property_value;
            
        end
        
        
        %setter for Vehicles Property
        function obj = set_Vehicles(obj,property_value)
            
            obj.Vehicles = property_value;
            
        end
        
        
        %setter for Vehicle Property
        function obj = set_Vehicle(obj,property_value)
            
            obj.Vehicle = property_value;
            
        end
        
        
        %setter for RoutingDecisions Property
        function obj = set_RoutingDecisions(obj,property_value)
            
            obj.RoutingDecisions = property_value;
            
        end
        
        
        %setter for RoutingDecision Property
        function obj = set_RoutingDecision(obj,property_value)
            
            obj.RoutingDecision = property_value;
            
        end
        
        
        %setter for Routes Property
        function obj = set_Routes(obj,property_value)
            
            obj.Routes = property_value;
            
        end
        
        
        %setter for Route Property
        function obj = set_Route(obj,property_value)
            
            obj.Route = property_value;
            
        end
        
        
        %setter for DesiredSpeedDecisions Property
        function obj = set_DesiredSpeedDecisions(obj,property_value)
            
            obj.DesiredSpeedDecisions = property_value;
            
        end
        
        
        %setter for DesiredSpeedDecision Property
        function obj = set_DesiredSpeedDecision(obj,property_value)
            
            obj.DesiredSpeedDecision = property_value;
            
        end
        
        
        %setter for ReducedSpeedAreas Property
        function obj = set_ReducedSpeedAreas(obj,property_value)
            
            obj.ReducedSpeedAreas = property_value;
            
        end
        
        
        %setter for ReducedSpeedArea Property
        function obj = set_ReducedSpeedArea(obj,property_value)
            
            obj.ReducedSpeedArea = property_value;
            
        end
        
        
        %setter for StopSigns Property
        function obj = set_StopSigns(obj,property_value)
            
            obj.StopSigns = property_value;
            
        end
        
        
        %setter for StopSign Property
        function obj = set_StopSign(obj,property_value)
            
            obj.StopSign = property_value;
            
        end
        
        
        %setter for StaticObjects Property
        function obj = set_StaticObjects(obj,property_value)
            
            obj.StaticObjects = property_value;
            
        end
        
        
        %setter for StaticObject Property
        function obj = set_StaticObject(obj,property_value)
            
            obj.StaticObject = property_value;
            
        end
        
        
        %setter for SignalControllers Property
        function obj = set_SignalControllers(obj,property_value)
            
            obj.SignalControllers = property_value;
            
        end
        
        
        %setter for SignalController Property
        function obj = set_SignalController(obj,property_value)
            
            obj.SignalController = property_value;
            
        end
        
        
        %setter for Detectors Property
        function obj = set_Detectors(obj,property_value)
            
            obj.Detectors = property_value;
            
        end
        
        
        %setter for Detector Property
        function obj = set_Detector(obj,property_value)
            
            obj.Detector = property_value;
            
        end
        
        
        %setter for SignalGroups Property
        function obj = set_SignalGroups(obj,property_value)
            
            obj.SignalGroups = property_value;
            
        end
        
        
        %setter for SignalGroup Property
        function obj = set_SignalGroup(obj,property_value)
            
            obj.SignalGroup = property_value;
            
        end
        
        
        %setter for SignalHeads Property
        function obj = set_SignalHeads(obj,property_value)
            
            obj.SignalHeads = property_value;
            
        end
        
        
        %setter for SignalHead Property
        function obj = set_SignalHead(obj,property_value)
            
            obj.SignalHead = property_value;
            
        end
        
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Getters methods
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        % Getter for  Vissim property
        function res = get_Vissim(obj)
            
            res = obj.Vissim;
            
        end
        % Getter for  VissimVersion property
        function res = get_VissimVersion(obj)
            
            res = obj.VissimVersion;
            
        end
        % Getter for  nControllers property
        function res = get_nControllers(obj)
            
            res = obj.nControllers;
            
        end
        % Getter for nLinks  property
        function res = get_nLinks(obj)
            
            res = obj.nLinks;
            
        end
        % Getter for  Net property
        function res = get_Net(obj)
            
            res = obj.Net;
            
        end
        % Getter for  Links property
        function res = get_Links(obj)
            
            res = obj.Links;
            
        end
        % Getter for  Link property
        function res = get_Link(obj)
            
            res = obj.Link;
            
        end
        % Getter for  Nodes property
        function res = get_Nodes(obj)
            
            res = obj.Nodes;
            
        end
        % Getter for  Node property
        function res = get_Node(obj)
            
            res = obj.Node;
            
        end
        % Getter for  ParkingLots property
        function res = get_ParkingLots(obj)
            
            res = obj.ParkingLots;
            
        end
        % Getter for  ParkingLot property
        function res = get_ParkingLot(obj)
            
            res = obj.ParkingLot;
            
        end
        % Getter for Paths  property
        function res = get_Paths(obj)
            
            res = obj.Paths;
            
        end
        % Getter for Path  property
        function res = get_Path(obj)
            
            res = obj.Path;
            
        end
        % Getter for DrivingBehaviorParSets  property
        function res = get_DrivingBehaviorParSets(obj)
            
            res = obj.DrivingBehaviorParSets;
            
        end
        % Getter for  TrafficCompositions property
        function res = get_TrafficCompositions(obj)
            
            res = obj.TrafficCompositions;
            
        end
        % Getter for  TrafficComposition property
        function res = get_TrafficComposition(obj)
            
            res = obj.TrafficComposition;
            
        end
        % Getter for VehicleImputs  property
        function res = get_VehicleImputs(obj)
            
            res = obj.VehicleImputs;
            
        end
        % Getter for  VehicleImput property
        function res = get_VehicleImput(obj)
            
            res = obj.VehicleImput;
            
        end
        % Getter for  Vehicles property
        function res = get_Vehicles(obj)
            
            res = obj.Vehicles;
            
        end
        % Getter for  Vehicle property
        function res = get_Vehicle(obj)
            
            res = obj.Vehicle;
            
        end
        % Getter for  RoutingDecisions property
        function res = get_RoutingDecisions(obj)
            
            res = obj.RoutingDecisions;
            
        end
        % Getter for  RoutingDecision property
        function res = get_RoutingDecision(obj)
            
            res = obj.RoutingDecision;
            
        end
        % Getter for  Routes property
        function res = get_Routes(obj)
            
            res = obj.Routes;
            
        end
        % Getter for  Route property
        function res = get_Route(obj)
            
            res = obj.Route;
            
        end
        % Getter for  DesiredSpeedDecisions property
        function res = get_DesiredSpeedDecisions(obj)
            
            res = obj.DesiredSpeedDecisions;
            
        end
        % Getter for  DesiredSpeedDecision property
        function res = get_DesiredSpeedDecision(obj)
            
            res = obj.DesiredSpeedDecision;
            
        end
        % Getter for  ReducedSpeedAreas property
        function res = get_ReducedSpeedAreas(obj)
            
            res = obj.ReducedSpeedAreas;
            
        end
        % Getter for  ReducedSpeedArea property
        function res = get_ReducedSpeedArea(obj)
            
            res = obj.ReducedSpeedArea;
            
        end
        % Getter for  StopSigns property
        function res = get_StopSigns(obj)
            
            res = obj.StopSigns;
            
        end
        % Getter for  StopSign property
        function res = get_StopSign(obj)
            
            res = obj.StopSign;
            
        end
        % Getter for  StaticObjects property
        function res = get_StaticObjects(obj)
            
            res = obj.StaticObjects;
            
        end
        % Getter for  StaticObject property
        function res = get_StaticObject(obj)
            
            res = obj.StaticObject;
            
        end
        % Getter for  SignalControllers property
        function res = get_SignalControllers(obj)
            
            res = obj.SignalControllers;
            
        end
        % Getter for  SignalController property
        function res = get_SignalController(obj)
            
            res = obj.SignalController;
            
        end
        % Getter for  Detectors property
        function res = get_Detectors(obj)
            
            res = obj.Detectors;
            
        end
        % Getter for  Detector property
        function res = get_Detector(obj)
            
            res = obj.Detector;
            
        end
        % Getter for  SignalGroups property
        function res = get_SignalGroups(obj)
            
            res = obj.SignalGroups;
            
        end
        % Getter for SignalGroup  property
        function res = get_SignalGroup(obj)
            
            res = obj.SignalGroup;
            
        end
        % Getter for  SignalHeads property
        function res = get_SignalHeads(obj)
            
            res = obj.SignalHeads;
            
        end
        % Getter for  SignalHead property
        function res = get_SignalHead(obj)
            
            res = obj.SignalHead;
            
        end
        
        
        %%%%%%%%%% Checked methods%%%%%%%%%%%%%%%
        
        % Check :)
        function val =  AttValue(obj, property )
            
            
            %Properties for Vissim Objects
            
            if(strcmp(property, 'MENU'))
                
                val = obj.Vissim.AttValue('MENU');
                
            elseif (strcmp(property, 'REVISION'))
                
                val = obj.Vissim.AttValue('REVISION');
                
            elseif (strcmp(property, 'INPUTFILE'))
                
                val = obj.Vissim.AttValue('INPUTFILE');
                
            elseif (strcmp(property, 'WORKINGFOLDER'))
                
                val = obj.Vissim.AttValue('WORKINGFOLDER');
                
            elseif (strcmp(property, 'EXEFOLDER'))
                
                val = obj.Vissim.AttValue('EXEFOLDER');
                
            elseif (strcmp(property, 'LANGUAGE'))
                
                val = obj.Vissim.AttValue('LANGUAGE');
                
            elseif (strcmp(property, 'TOOLBAR'))
                
                val = obj.Vissim.AttValue('TOOLBAR');
                
            elseif (strcmp(property, 'VERSION'))
                
                val = obj.Vissim.AttValue('VERSION');
                
            elseif (strcmp(property, 'UNITDISTANCE1'))
                
                val = obj.Vissim.AttValue('UNITDISTANCE1');
                
            elseif (strcmp(property, 'UNITDISTANCE2'))
                
                val = obj.Vissim.AttValue('UNITDISTANCE2');
                
            elseif (strcmp(property, 'UNITSPEED'))
                
                val = obj.Vissim.AttValue('UNITSPEED');
                
            elseif (strcmp(property, 'UNITACCEL'))
                
                val = obj.Vissim.AttValue('UNITACCEL');
                
            end
        end
        
        
        %Save netwrk
        function obj = SaveNet(obj)
            
            obj.Vissim.SaveNet;
            
        end
        
        % Place: path where u will save your file
        % NameNtwrk: inp file's name
        function obj = SaveNetAs(obj, nameNtwrk, place)
            
            obj.Vissim.SaveNetAs(strcat(place,'\',nameNtwrk,'.inp'));
            
        end
        
        % Load VISSIM layout File *.INI
        function obj = loadLayout(obj, layoutPath,nameFile)
            
            obj.Vissim.LoadLayout(strcat(layoutPath, '\', nameFile, '.layx'));
            
            
        end
        
        % Save the layout file
        function obj =  saveLayout(obj,layoutPath)
            
            obj.Vissim.SaveLayout(layoutPath);
        end
        
        % erase the vissim object. Be careful with this function. the
        % VISSIMCOMINTERFACE object may be suprimmed if this is invocated
        function obj =  exit(obj)
            
            obj.Vissim.Exit;
            
        end
        
        
        function obj = showMaximized(obj)
            
            obj.Vissim.ShowMaximized;
            
        end
        
        function obj = showMinimized(obj)
            
            obj.Vissim.ShowMinimized;
            
        end
        
        %Coordenadas de la ventana actual, en pixeles.
        function [top left bottom right] = getWindow(obj)
            
            [top left bottom right]  = obj.Vissim.GetWindow;
            
        end
        %%%%%seguir p�gina 23
        
        
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Doesn't check!
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        function  sensors = getSensors(obj)
            
            
            nqc = obj.Vissim.Net.QueueCounters.Count;
            
            sensors = cell(1,nqc);
            for i = 1:nqc
                sensors{i} = obj.Vissim.net.QueueCounters.ItemByKey(i);
            end
        end
        
        
        %Returns the number of controllers in the model of vissim
        function res = numControllers(obj)
            
            res =obj.Vissim.Net.SignalControllers.Count;
            
        end
        
        %Returns the queue counter by number
        function res = getQueueCounterByNumber(obj,iqc)
            
            res =obj.Vissim.net.QueueCounters.ItemByKey(iqc);
            
        end
        
        %Returns the number of queue counters
        function res = numQueueCounters(obj)
            
            res =obj.Vissim.Net.QueueCounters.Count;
        end
        
        
        %Returns the name of queue counter number isc
        function res = nameQueueCounterByNumber(obj,isc)
            
            res =obj.Vissim.net.SignalControllers.ItemByKey(isc).Name;
        end
        
        %Returns the name of queue counter number isc
        function res = numSignalGroupsByNumberController(obj,isc)
            
            res =obj.Vissim.net.signalControllers.ItemByKey(isc).SGs.Count;
        end
        
        
        
        
        %%%%%%%% TODO
        
        function res = getVehicleImputsByNumber(obj,iqc)
            
            res =obj.Vissim.net.QueueCounters.ItemByKey(iqc);
            
        end
        
        
        
        %%%%%%%%%%%
        
        %Returns the signal controller by number
        function res = getSignalControllerByNumber(obj,icll)
            
            obj.Vissim.Net.SignalControllers.ItemByKey(icll);
            
        end
        
        % This function imports an *.ANM File. This file share info between
        % VISSIM and VISSUM.
        function importANM( netPath, routesPath, inputPath, importType, ...
                importOptions, evaluationInterval)
            
            obj.Vissim.ImportANM([netPath, routesPath, inputPath, importType, ...
                importOptions, evaluationInterval]);
            
        end
        
    end % Methods
end % Class
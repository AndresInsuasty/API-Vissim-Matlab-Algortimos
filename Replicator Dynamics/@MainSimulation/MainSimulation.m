%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%                        Universidad de los Andes                         %
%           Departamento de ingeniería Eléctrica y Electrónica            %
%    Grupo de Investigación en Automatización y para la producción GIAP   %
%                                                                         %
%               Urban Traffic Simulator VISSIM - MATLAB                   %
%                                                                         %
%                By: Iván Felipe Gutiérrez Delgado                        %
%                                                                         %
%       This is class controlls all data and send it to  interfaz         %
%                                                                         %
%                                                                         %
%    First revision: March 25 / 2013                                      %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


classdef MainSimulation
    
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Properties
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
    
    properties
     
     % Signal plan in ejecution
     sp_actual   
     
     %previous Signal plan used (Historic)
     sp_old
     
     %Signal Plan calculated by ControllerUserDefined.
     sp_from_controller
     
     % Actual queues in the grid.
     actual_queues
     
     % Hybrid Controller instances. This simbolize each controller in the
     % network.
     hybrid_Controllers
     
     % Instance of controllerUserDefined instance.
     contrl_user_defined
     
     % Instance of InterfaceAndResults instance.
     interfaceAndResults
     
     % Instance of VISSIMCOMInterface instance.
     Vissim
     
     % Instance of UtNSimulation instance.
     UTNSimulation
     
     %Signal Plan instance
     signal_Plan
     
     % Total time of simulation
     total_time
        
     %real time in simulation (INITIAL = 0 SEG)
     rt =0;
     
     % Intervalo de simulación %%%%%% ESTO TIENE QUE PONERSE EN LA INTERFAZ
     % EN UNA NUEVA VERSIÓN!!
     at = 5;
     
     % RD instance
     RDTC;
     
    end
    
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Methods    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
    methods
   
      % Constructor of class  
        function obj = MainSimulation(vissim_version,path_vissim,name_vissim_network...
                ,name_vissim_layout,n_s_g, cycle_time,order_p, minTao_p, nc, sensor_asignment,...
                nqc,yellowTime,RATime,total_time)


     % Instance of VISSIMCOMInterface instance.
     obj.Vissim = COMInterfaceVISSIM(vissim_version,name_vissim_network,name_vissim_layout,path_vissim);
     % Actual queues in the grid.  DONE This is not used.... in a new
     % revision I will fix this and fix the new structure of the simulator
     obj.actual_queues = cell(3,3);
     
         %Initial SP from Imatic info
    
        LoadSPBarranquilla;
     
     % Hybrid Controller instances. This simbolize each controller in the
     % network.
     
     %%%%% Getting sensors fron the vissim instance
     sensors = obj.Vissim.getSensors();
     
     for i = 1: nc
         for j =1: n_s_g(i)
             if sensor_asignment(i,j) < nqc+1
                SensorsIn{i}{j} =sensors{sensor_asignment(i,j)};    
             else
%                 SensorsIn{i}{j} = 0;
                 SensorsIn{i}{j} = 0;

             end         
         end
         hybrid_c(i) = HybridController(SpDB,i,SensorsIn{i});
         clear SensorsIn
     end
        obj.hybrid_Controllers = hybrid_c;
     % Instance of InterfaceAndResults instance. FUTURE WORK
     %obj.interfaceAndResults =
     
     vissimOBJ = obj.Vissim.get_Vissim();
     ControllerArr = obj.hybrid_Controllers;
     
     % Instance of controllerUserDefined instance. DONE
     obj.contrl_user_defined = ControllerUserDefined(); 
     
     %%%% ERASE THE RD INSTANCE FOR YUOR SIMULATIONS!
     % ------------------------------------------------------------------------
% Create Replicator Dynamics Controlers for Traffic a 
U_phases(1,:) = [11 6];
U_phases(2,:) = [10 6];
U_phases(3,:) = [1 7];
U_phases(4,:) = [1 7];
U_phases(5,:) = [7 1];
U_phases(6,:) = [6 10];
U_phases(7,:) = [4 9];
U_phases(8,:) = [1 4];

% cycle time


cycle = 120-20;

Ps = cycle.*ones(1,8);
Ps(1) = cycle+1;
Ps(2) = cycle-4;
Ps(3) = cycle-7;
Ps(4) = cycle-2;
Ps(5) = cycle+3;
Ps(6) = cycle-2;
Ps(7) = cycle+4;
Ps(8) = cycle+7;

for inc = 1:8
    RDTC(inc) = RD_traffic(SpDB,inc,obj.hybrid_Controllers(inc),Ps(inc),U_phases(inc,:));
end
     obj.RDTC = RDTC;
     
    
     %Signal Plan instance
     obj.signal_Plan = SignalPlan(n_s_g, cycle_time,order_p, minTao_p,RATime,yellowTime);
     %Total time simulation assign
     obj.total_time = total_time;
     % Getting the signal plan with the info from the green Times and
     % Signal Plan instance
 %    SpDB=obj.getSP(greenT,nc);
     
     % Actual signal Plan   
     obj.sp_actual =  SpDB;     
     %previous Signal plan used (Historic) DONE
     obj.sp_old = SpDB;
     %Signal Plan calculated by SignalPlan instance.  DONE
     obj.sp_from_controller = SpDB;  

     
     
     
     
     % Instance of UTNSimulation instance.
     obj.UTNSimulation = UTNSimulation(vissimOBJ,ControllerArr,SpDB);  
        end
        
        
        % Start Simulation
        function obj= startSimulation(obj)
       
         % Reading info from the respective instances
            nc = length(obj.hybrid_Controllers);
            SpDB = obj.get_sp_actual();
            
            
         % Drawing signal plan   
            
            stateIn = [];
            drawFig = 0;
            ID = [];
            t = [];
            Njumps = 40;
              
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % Main execution                                   %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            bandera=0
            while obj.rt < obj.total_time
                
                % Drawing signal plan   
%             for i = 1:nc
%                 Figure{i} = figure(i);
%                 obj.signal_Plan.DrawSignalPlan(SpDB,Figure{i},obj.UTNSimulation.Controllers(i));
%             end
%            drawnow
                 obj.rt = obj.rt+ obj.at;
                
                [Model IDtemp stateOut t_temp] = obj.UTNSimulation.simNetwork(drawFig,obj.rt,Njumps,stateIn);
                
                obj.UTNSimulation = Model;
                controllers = obj.UTNSimulation.Controllers;
                   
%                 figure(100);
%                 clf
%                 
                  % Se asignan las colas de IDtemp a ID{icll} 
                for icll = 1:length(obj.UTNSimulation.Controllers(:))
                    ID{icll}(:,length(t)+1:length(t)+length(t_temp)) = IDtemp{icll};
                end
                t(1,end+1:end+length(t_temp)) = t_temp;    
%                 for icll = 1:nc
%                     subplot(nc,1,icll),plot(t,ID{icll});
%                 end    
%                drawnow
                Tspan = [t_temp(1) t_temp(end)];

                % Put here The adaptative indexes
                obj.contrl_user_defined.ID1 = ID;
                %obj.contrl_user_defined.ID2 = wherever u want
                %obj.contrl_user_defined.ID3 = wherever u want
                %obj.contrl_user_defined.ID4 = wherever u want
                %obj.contrl_user_defined.ID5 = wherever u want
                
                
                 % Getting the signal plan calculated by ControllerUserDefined CLass
                 [signalP control RD] = obj.contrl_user_defined.calculateGreen(controllers,obj.RDTC, Tspan); 
                 obj.RDTC = RD;
               
                
                obj.contrl_user_defined = control;
                % Getting the signal plan calculated by ControllerUserDefined CLass
                 SpDB = signalP;
                 % Actual signal Plan   
                 obj.sp_actual =  SpDB;     
                 %previous Signal plan used (Historic) DONE
                 obj.sp_old = SpDB;
                 %Signal Plan calculated by SignalPlan instance.  DONE
                 obj.sp_from_controller = SpDB;

                
                
     %%%%%%%%%%%%%%%%%%%%%%
     for icll = 1:nc%length(ModelSim.Controllers(:))
        controllers(icll).SpDB = obj.sp_actual;
     end
    
     %%%%HAY QUE REVISAR ESTO EN EL FUTURO, SIMULA BIEN, PERO HAY QUE
     %%%%REVISAR SI ES LO ADECUADO...VERIFICAR QUÉ INSTANCIA EN VERDAD ES
     %%%%LA QUE SE ENCUENTRA SIMULANDO ETC.
    vissimOBJ = obj.Vissim.get_Vissim();
     % Instance of UtNSimulation instance.
     obj.UTNSimulation = UTNSimulation(vissimOBJ,controllers,obj.sp_actual);
                

            end
            bandera=bandera+1
        end
        %end

        % Creates a control based in the info gotten from the interfaz
%         function  obj= createControlUser(obj,PathName)
%         
%             addpath(PathName);
%             
%             obj.contrl_user_defined = ControllerUserDefined();
%             
%             % remuevo del path para poder agregar más simulaciones después
%             % y que no entre en conflicto con este archivo de control, pues
%             % existirían varios constructores de la misma clase.
% 
%             rmpath(PathName);
%                         
%         end

        % This function gets the signal plan
        function SpDB = getSP(obj, greenT, numCrlls)
           
            if nargin ==2
                nc = length(obj.hybrid_Controllers);         
            elseif nargin ==3       
                nc = numCrlls;
            end
 
          
            % Getting info
            n_s_g = obj.signal_Plan.get_nsg();
            order_p = obj.signal_Plan.get_order();
            cycle_time = obj.signal_Plan.get_cycle();
            minTao_p = obj.signal_Plan.get_minTao();
            TRA= obj.signal_Plan.get_RATime();
            yellowTime = obj.signal_Plan.get_yellowTime();
            
            
          
     for i =1 : nc        
     C = cycle_time(i);
     inGreen = minTao_p{i};
     
     % ESTO ESTA PARA EL CASO ESPECIFICO DE MI SIMULACION. POR LA NEGACIÓN
     % DE MI PENDIENTE NO TUVE TIEMPO DE HACERLO GENÉRICO. LA IDEA ES QUE
     % VERIFIQUE EN LA INSTANCIA DE CONTROLUSERDEFINED SI ES ADAPTATIVO, SI
     % LO ES, MODIFICAR EL INGREEN DE ACUERDO AL NUEVO TIEMPO DE VERDE,
     % PARA INTERSECCIONES DE N FASES.
     if(obj.contrl_user_defined.isAdaptative)
         
         inGreen = [2 greenT{i}(1)+yellowTime+2*TRA];
         
     end
     
     %[TRA greenT{i}(j) yellowTime -1]
        for j = 1: length(greenT{i}) 
            for k = 1: length(order_p{i,j})
                
                if order_p{i,j}(k) ==1 % Red Amber time
                    minT{j}(k) = TRA;
                    
                elseif order_p{i,j}(k) ==2 % Green time
                    minT{j}(k) = greenT{i}(j);
                    
                elseif order_p{i,j}(k) ==3 % green intermitent
                    minT{j}(k) = 2;
                    
                elseif order_p{i,j}(k) ==4 % Yellow
                    minT{j}(k) = yellowTime;
                    
                elseif order_p{i,j}(k) ==5 % red
                    minT{j}(k) = -1;

                elseif order_p{i,j}(k) ==6 % Not Selected
                    order_p{i,j}(k) = [];
                end
            end    
        end
        clear aaa;
        aaa = cell(1,n_s_g(i));
        for qq =1 : n_s_g(i)
            aaa{qq} = order_p{i,qq};
        end
        
        ind = 0;
        for ir=1: n_s_g(i)
  
            if ir>length(minT)
                
                aaa(ir-ind) = [];
                inGreen(ir-ind) = [];
                ind = ind+1;
                
            end
            
            
        end
        
        
     SpX = obj.signal_Plan.GetSp(inGreen',minT,C,aaa);
     clear minT;
     SpDB{1,i,1}= SpX{1};
     SpDB{1,i,2}= SpX{2};
            end
        
        end
        
        
        
%         
%         % This function gets the property order from SignalPlan Instance
% % and returns the correct value in accordance to the number of signal group
%         function res = getOrderByNsg(obj,nsg)
%         
%             a = obj.signal_Plan;
%             b = a.get_order();
%             res = b{nsg};
%             
%         end
%         
%          % This function gets the property minTao from SignalPlan Instance
% % and returns the correct value in accordance to the number of signal group
%         function res = getMinTaoByNsg(obj,nsg)
%         
%             a = obj.signal_Plan.get_minTao();
%             res = a{nsg};
%             
%         end
%         
%         
%         
%         
%         % This function creates an instance of class SignalPlan
%         % this instance is created with a few properties, but not all, 
%         % because I want to save info recolected in the interface here.  
%         function obj = createSignalPlanInstance(obj, nsg, cycletime)
%             
%             obj.signal_Plan = SignalPlan(nsg,cycletime);
%             
%         end
        
        
        
        
        
        
        
    %%%%%%%% getters and setters  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
        
    %getter for  signal_Plan  Property    
        function res = get_signal_Plan(obj)
            
            res = obj.signal_Plan;
            
        end
        
    %setter for  signal_Plan property
    
    function obj = set_signal_Plan(obj, property_value)
        
        obj.signal_Plan = property_value;
    end
  
    
    
    %getter for  sp_actual  Property    
        function res = get_sp_actual(obj)
            
            res = obj.sp_actual;
            
        end
        
    %setter for  sp_actual property
    
    function obj = set_sp_actual(obj, property_value)
        
        obj.sp_actual = property_value;
    end
    
        %getter for  sp_old  Property    
        function res = get_sp_old(obj)
            
            res = obj.sp_old;
            
        end
        
    %setter for sp_old property
    
    function obj = set_sp_old(obj, property_value)
        
        obj.sp_old = property_value;
    end
    
        %getter for  sp_from_controller  Property    
        function res = get_sp_from_controller(obj)
            
            res = obj.sp_from_controller;
            
        end
        
    %setter for sp_from_controller property
    
    function obj = set_sp_from_controller(obj, property_value)
        
        obj.sp_from_controller = property_value;
    end
    
    
    
        %getter for  actual_queues  Property    
        function res = get_actual_queues(obj)
            
            res = obj.actual_queues;
            
        end
        
    %setter for actual_queues property
    
    function obj = set_actual_queues(obj, property_value)
        
        obj.actual_queues = property_value;
    end
        %getter for  hybrid_Controllers  Property    
        function res = get_hybrid_Controllers(obj)
            
            res = obj.hybrid_Controllers;
            
        end
        
    %setter for hybrid_Controllers property
    
    function obj = set_hybrid_Controllers(obj, property_value)
        
        obj.hybrid_Controllers = property_value;
    end
    
        %getter for  contrl_user_defined  Property    
        function res = get_contrl_user_defined(obj)
            
            res = obj.contrl_user_defined;
            
        end
        
    %setter for contrl_user_defined property
    
    function obj = set_contrl_user_defined(obj, property_value)
        
        obj.contrl_user_defined = property_value;
    end
        %getter for  interfaceAndResults  Property    
        function res = get_interfaceAndResults(obj)
            
            res = obj.interfaceAndResults;
            
        end
        
    %setter for interfaceAndResults property
    
    function obj = set_interfaceAndResults(obj, property_value)
        
        obj.interfaceAndResults = property_value;
    end
        %getter for    Property    
        function res = get_Vissim(obj)
            
            res = obj.Vissim;
            
        end
        
    %setter for property
    
    function obj = set_Vissim(obj, property_value)
        
        obj.Vissim = property_value;
    end
        %getter for    Property    
        function res = get_UTNSimulation(obj)
            
            res = obj.UTNSimulation;
            
        end
        
    %setter for property
    
    function obj = set_UTNSimulation(obj, property_value)
        
        obj.UTNSimulation = property_value;
    end
    
     
    
    
    end
    
    
end
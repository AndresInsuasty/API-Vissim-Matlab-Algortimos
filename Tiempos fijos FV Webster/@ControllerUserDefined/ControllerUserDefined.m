%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%                        Universidad de los Andes                         %
%           Departamento de ingeniería Eléctrica y Electrónica            %
%    Grupo de Investigación en Automatización y para la producción GIAP   %
%                                                                         %
%               Urban Traffic Simulator VISSIM - MATLAB                   %
%                                                                         %
%                By: Iván Felipe Gutiérrez Delgado                        %
%                                                                         %
%       This class manages the green times used for MainSimulation        %
%                                                                         %
%                                                                         %
%    First revision: March 25 / 2013                                      %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef ControllerUserDefined
    
properties
    
    %green time based on fixed time strategies
    g_fixed;
    
    %green time based on adaptative strategies
    g_adaptative;
    
    % Indice de desempeño 1: queues
    ID1
    
    % Indice de desempeño 2
    ID2

    % Indice de desempeño 3
    ID3
    
    % Indice de desempeño 4
    ID4
    
    % Indice de desempeño 5
    ID5    
    
    % flujo de entrada q(i,j), i = numContrller , j = numphase
    q = [1000 1000 ; 1000 1000 ; 1000 1000 ; 1000 1000 ;...
        1000 1000 ; 1000 1000 ; 1000 1000 ; 1000 1000 ];
    
    % Flujo de saturación
    s = 2400;
    
end

methods
    
    % Constructor of class ControllerUserDefined
    function obj = ControllerUserDefined()

        %You may put here the fixed time signal plan! in the "fixed"
        %variable
%%------------------------------------------------------------------------
% Signal plan example and compability
% ------------------------------------------------------------------------

% Example 01
% Four controllers
% Controller 1: Calle 82 con Carrera 52
% Controller 2: Calle 82 con Carrera 51B
% Controller 3: Calle 82 con Carrera 51
% Controller 4: Calle 82 con Carrera 50
% SpDB{i,j,k}: Signal plan Data Base.
% i) Controller
% j) Signal plan
% k = 1) Signal state matrix (signal groups x number of states)
% k = 2) Time vector
    Green{1} = [27 23 21 25];
    Green{2} = [28 22 21 26];
    Green{3} = [31 19 17 29];
    Green{4} = [31 19 17 29];
    Green{5} = [26 23 20 25];
    Green{6} = [27 23 19 25];
    Green{7} = [27 23 20 26];
    Green{8} = [29 20];

        obj.g_fixed = Green;
        
        % Here you may put the initial lights times for your controller
        obj.g_adaptative = Green;
                
    end
    
    
    
    % getter for g_fixed properties
     function res = get_g_fixed(obj)

        res = obj.g_fixed;
        
     end

         % getter for g_adaptative properties
     function res = get_g_adaptative(obj)

        res = obj.g_adaptative;
        
     end
     

         % setter for g_fixed properties
     function obj = set_g_fixed(obj,fixed)

        obj.g_fixed = fixed;
        
     end

         % setter for g_adaptative properties
     function obj =set_g_adaptative(obj,adaptative)

        obj.g_adaptative= adaptative;
        
     end
     

              % getter for ID1 properties
     function res = get_ID1(obj)

        res = obj.ID1;
        
     end
     

         % setter for ID1 properties
     function obj = set_ID1(obj,fixed)

        obj.ID1 = fixed;
        
     end

                   % getter for ID2 properties
     function res = get_ID2(obj)

        res = obj.ID1;
        
     end
     

         % setter for ID2 properties
     function obj = set_ID2(obj,fixed)

        obj.ID2 = fixed;
        
     end

                   % getter for ID3 properties
     function res = get_ID3(obj)

        res = obj.ID3;
        
     end
     

         % setter for ID3 properties
     function obj = set_ID3(obj,fixed)

        obj.ID3 = fixed;
        
     end
              % getter for ID4 properties
     function res = get_ID4(obj)

        res = obj.ID4;
        
     end
     

         % setter for ID4 properties
     function obj = set_ID4(obj,fixed)

        obj.ID4 = fixed;
        
     end
     
     % getter for ID5 properties
     function res = get_ID5(obj)

        res = obj.ID5;
        
     end
     

         % setter for ID1 properties
     function obj = set_ID5(obj,fixed)

        obj.ID5 = fixed;
        
     end


     
     
     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NOTE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% You may create an cell with the green times for each phase
% at everyone intersection, and save it at g_adaptative or g_fixed
% THIS FUNCTION MAY NOT CHANGE THEIR NAME. IF YOU DO IT, NOTHING WILL WORK
% The cell format is this: Green{nc} = [GTPh1 GTPh2 ... GTPhn]
% Where:
% 

function res=  calculateGreen(obj)
    
    y = obj.q./obj.s;
    Y = sum(y,2);
    R = 3*2+2*2;
    %%% optimum cycle time
    opt_cicle_time = (1.5*R+5)./(1-Y)

    %%% Efective green times
g = [ (opt_cicle_time-R*ones(8,1)) (opt_cicle_time- R*ones(8,1))].*(y./[Y Y])
    g = g - 3*ones(8,2)
    
    Green{1} = [g(1,1) g(1,2)];
    Green{2} = [g(2,1) g(2,2)];
    Green{3} = [g(3,1) g(3,2)];
    Green{4} = [g(4,1) g(4,2)];
    Green{5} = [g(5,1) g(5,2)];
    Green{6} = [g(6,1) g(6,2)];
    Green{7} = [g(7,1) g(7,2)];
    Green{8} = [g(8,1) g(8,2)];
    
    obj.g_fixed = Green;
    res = obj.g_fixed;
    
    % Los tiempos verdes qeu se calculen se guardan aquí... en green_t
    %green_t = {};
    %obj.g_adaptative = green_t;
    
end


end %Methods
end %Class
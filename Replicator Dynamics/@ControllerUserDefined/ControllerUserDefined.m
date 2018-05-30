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
    
    % If this property is equal to 1, the strategy described is adaptative,
    %zero if is a fixed strategy
    isAdaptative =1;
    
    %first green Calculation? 
    first;
    
    %Initial control vector
    uou
    

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
        obj.first = 1;
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
% This file calculates the respectives green times for RD based TC
function [res obj RDTC]=  calculateGreen(obj, controllers, RDTC, Tspan)

    
    ID = obj.ID1;
    
    for icll = 1:8
        RDTC(icll) = RDTC(icll).simRD(Tspan,ID{icll}(:,end));
        controllers(icll).SpDB = RDTC(icll).SpDB;
        ruru= RDTC(icll).SpDB;
        SpDB{1,icll,1} = ruru{1,icll,1};              
        SpDB{1,icll,2} = ruru{1,icll,2};              

        %         SpActive{1,icll,1} = controllers(icll).SP{1};
%         SpActive{1,icll,2} = controllers(icll).SP{2};
    end
    
    
    
    
    %%% TODO: Acomodar la información y enviarla
%   
%     Green{1} = [Sp1(1) Sp1(2)];
%     Green{2} = [Sp1(3) Sp1(4)];
%     Green{3} = [Sp1(5) Sp1(6)];
%     Green{4} = [Sp1(7) Sp1(8)];
%     Green{5} = [Sp1(9) Sp1(10)];
%     Green{6} = [Sp1(11) Sp1(12)];
%     Green{7} = [Sp1(13) Sp1(14)];
%     Green{8} = [Sp1(15) Sp1(16)];    
    res = SpDB;
    
end

end %Methods
end %Class
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
%       This class manages the green times used for MainSimulation        %
%                                                                         %
%                                                                         %
%    First revision: March 25 / 2013                                      %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef InterfaceAndResults
    
properties
    
    
    TTV
    DTV
    VP
    queues
    TTP
    RP
    
    
end

methods
    
    % Constructor of class Interfaceandresults
    function obj = InterfaceAndResults(TTV_par, DTV_par, VP_par,...
            queues_par,TTP_par, RP_par)
        
        obj.TTV = TTV_par;
        obj.DTV = DTV_par;
        obj.VP = VP_par;
        obj.queues = queues_par;
        obj.TTP = TTP_par;
        obj.RP = RP_par;

    end
    
    

end %Methods
end %Class
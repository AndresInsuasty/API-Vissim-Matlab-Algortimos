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
    
    % Indice de desempeño 2: Green Restante
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
    
    % Q learning Matrix (value-action function)
    Q;
    
    % Cycle time
    TC
    
    % First execution
    first =1;
    
    % Reward Value for each agent
    reward;
    
    % Previous state
    ID1_old;
    
    % Previous action taken
    action_old
    
    % Neighborhood of each controller
    I
    
    % Optimal messages between agents
    mu;
    
    % time remaining
    rt = 360;
    
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
        % Initializing the reward
        obj.reward = zeros(8,1);
        
        % Defining Neighborhood of each agent
        II{1} = [2 8];
        II{2} = [1 3 7];
        II{3} = [2 4 6];
        II{4} = [3 5];
        II{5} = [4 6];
        II{6} = [3 5 7];
        II{7} = [2 6 8];
        II{8} = [1 7];
        
        


        
        obj.I = II;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
        % cycle time
        obj.TC = 120;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        


        % Initializing optimal messages
        obj.mu = zeros(8,8,obj.TC-10-2);

        %Initializing the queues: ID1 ACTUAL STATE
        obj.ID1 = zeros(16,1);
        
        %Initializing the old queues: ID1 OLD STATE
        obj.ID1_old = zeros(8,2);
        
        % Initializing old actions
        obj.action_old = zeros(8,1);

       % Initializing Action Value Function  
       % 2 seg = minimum green
       % 10 seg = lost time in amber times
       % TC-10-2 = domain of remaining green time
       % TC-10-2 = domain action taken for local agent
       % TC-10-2 = domain action taken for neighbor agent
       % Q{q1,q2,gr,a_i,a_j}
       % where q1 = value of queue of phase 1 (0<=q1<=50) if greater, 20
       % where q2 = value of queue of phase 2 (0<=q2<=50) if greater, 20
       % gr = remaining green time of active phase FOR FUTURE Aplications
       % WHY? EXCEEDS 8GB RAM MEMORY FOR EACH SIMULATION - infeasible
       % a_i = action taken for a local agent
       % a_j = action taken for a neighbor agent
      
       %QQ = cell(4,4,obj.TC-10-2,obj.TC-10-2);
       %QQ(:,:,:,:,:)={0};
        load('Q.mat');
       obj.Q = ann;       
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
% This file calculates the respectives green times for DMPC 
function [res obj]=  calculateGreen(obj)

            % Initializing optimal messages
        obj.mu = zeros(8,8,obj.TC-10-2);

    
    if obj.first ==1
    
     % It will begin with a conservative strategy: Equal times
        Green{1} = [ (obj.TC-10)/2 (obj.TC-10)/2];
        Green{2} = [ (obj.TC-10)/2 (obj.TC-10)/2];
        Green{3} = [ (obj.TC-10)/2 (obj.TC-10)/2];
        Green{4} = [ (obj.TC-10)/2 (obj.TC-10)/2];
        Green{5} = [ (obj.TC-10)/2 (obj.TC-10)/2];
        Green{6} = [ (obj.TC-10)/2 (obj.TC-10)/2];
        Green{7} = [ (obj.TC-10)/2 (obj.TC-10)/2];
        Green{8} = [ (obj.TC-10)/2 (obj.TC-10)/2];
    
        obj.action_old = ((obj.TC-10)/2-1).*ones(8,1);
        obj.ID1_old =  obj.ID1;
        obj.first = 0;
    else

        % First calculating Reward
    rw = obj.calculateReward();    
        % Second: Updating Q 
    [obj ann] =obj.updateQ(rw);   
    obj.Q = ann;
    obj.rt = obj.rt-1;
    if obj.rt ==2
    save('Q.mat','ann');
    end
        %Third: Calculating action based in a policy
    act = obj.optimalAction();
        % Fourth: Sending actions to the simulator
     act = act+ones(8,1);
     
    Green{1} = [act(1) obj.TC-10-act(1)];
    Green{2} = [act(2) obj.TC-10-act(2)];
    Green{3} = [act(3) obj.TC-10-act(3)];
    Green{4} = [act(4) obj.TC-10-act(4)];
    Green{5} = [act(5) obj.TC-10-act(5)];
    Green{6} = [act(6) obj.TC-10-act(6)];
    Green{7} = [act(7) obj.TC-10-act(7)];
    Green{8} = [act(8) obj.TC-10-act(8)];
 
         act = act-ones(8,1);
        obj.action_old = act;
        obj.ID1_old =  obj.ID1;
    end
    %%% TODO: Acomodar la información y enviarla
    % Debugguear hasta aqui que DPMCtrafficController works well
       
    res =  Green;
    
end

function rw = calculateReward(obj)
    
    rw= zeros(8,1);
    qc_old = obj.ID1_old;
    qc = obj.ID1;
    
    for i = 1:8
       if(qc_old(2*i-1)>qc(2*i-1) && qc_old(2*i)>qc(2*i) )
            
           rw(i) = 1;
       elseif( (qc_old(2*i-1)>=qc(2*i-1) && qc_old(2*i)<=qc(2*i) ) ||...
               (qc_old(2*i-1)<=qc(2*i-1) && qc_old(2*i)>=qc(2*i) ) )
            
           rw(i) = 0.5;
           
       elseif(qc_old(2*i-1)<qc(2*i-1) && qc_old(2*i)<qc(2*i) )
            
           rw(i) = 0;
       end    
    end   
end

function [obj ann] =updateQ(obj, rw)
    
    II = obj.I;
  %  QQ = obj.Q;
  tc = obj.TC;
    for i = 1:8

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
% setting Old state 
        qc1 = obj.ID1_old(2*i-1)+1;
       qc2 = obj.ID1_old(2*i)+1;
       
       if(qc1>21)
           qc1 = 21;
       end
       
       if(qc2>21)
           qc2 = 21;
       end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    ar = -1;
    ass = obj.Q;
    for w = 1: obj.TC-10-2
        for ww = 1: obj.TC-10-2
            if(ass{qc1,qc2,w,ww}>ar)
                ar = ass{qc1,qc2,w,ww};
            end
        end 
    end 
    
    maxx = ar;
       
      % Ahora recorro los vecinos, miro sus acciones
        for j = 1:length(II{i})
        ass{qc1, qc2,obj.action_old(i), obj.action_old(II{i}(j))}  ...
            = rw(i) +0.9*maxx;
        end
        obj.Q =ass;
    end
    
    ann = obj.Q;
end

function act = optimalAction(obj)
        act = zeros(8,1);
        II = obj.I;
        ass = obj.Q;
        f=zeros(8,8,obj.TC-10-2,obj.TC-10-2);
    for i = 1:8
                
% setting state 
        qc1 = obj.ID1(2*i-1)+1;
       qc2 = obj.ID1(2*i)+1;
       
       if(qc1>21)
           qc1 = 21;
       end
       
       if(qc2>21)
           qc2 = 21;
       end

        %recorriendo los vecinos
        for j = 1:length(II{i})

% setting state 
        qc3 = obj.ID1(2*( II{i}(j) ) -1 ) +1;
        qc4 = obj.ID1( 2*II{i}(j) ) +1;
       
       if(qc3>21)
           qc3 = 21;
       end
       
       if(qc4>21)
           qc4 = 21;
       end

        
            % revisar!!!!!!!!!!!!!!!!
            %f_i,j(a_i,a_j)
            f(i,II{i}(j),obj.action_old(i), obj.action_old(II{i}(j))) =...
           ass{qc1, qc2,obj.action_old(i), obj.action_old(II{i}(j))} + ...
            ass{qc3, qc4,obj.action_old(II{i}(j)),obj.action_old(i)};
        end
    end    %f_i,j(a_i,a_j) Has been calculated
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  %%%%%%%%%%%%%%%%%  
    
    for i = 1:8
        for j = 1 : length(II{i})

             mu_temp = zeros(obj.TC-10-2,1);
        
     for wx = 1: obj.TC-10-2   
        for k = 1 : length(II{i})
            if ( II{i}(j) ~= II{i}(k) )
                mu_temp(wx) = mu_temp(wx) + obj.mu(k,i,wx);
            end
        end            
     end        
             an = zeros(obj.TC-10-2,1);
             for y = 1:obj.TC-10-2
                 an(y) =  f(i,II{i}(j),y,obj.action_old(II{i}(j)));
             end
           % Calculating mu's - (sub) optimal messages (Only 1 iteration)
            obj.mu(i,II{i}(j),obj.action_old(II{i}(j))) = ...
            max( an+ mu_temp);
            clear mu_temp;      
        end
    end
    %%%%%%%% Mu has been calculated %%%%%%%%%%%%%%%%%%%%%%%%%%%
    

    
    
    
    
    for i = 1:8
        tem =zeros(obj.TC-10-2,1);

        for j = 1: obj.TC-10-2 
            for k = 1:length(II{i})
                tem(j) = tem(j)+obj.mu(II{i}(k),i,j);
            end
        end
        
        [aa bb] = max(tem);
        act(i) = bb;
        clear tem;
        
    end
    
    if ~any(act)
        'Se logró papá'
    end
    
    for h = 1:8
        if aa ==0
           act(h) = round((obj.TC-10-4)*rand())+2;
            
        end
    end

end




end %Methods
end %Class
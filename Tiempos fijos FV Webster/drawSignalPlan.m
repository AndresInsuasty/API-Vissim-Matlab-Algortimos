function [] = DrawSignalPlan(SpX,FigIn,controlers)
in = nargin;

% nsg: Number of signal groups
% mp: Number of phases in each signal plan
% nSP: Number of signal plans to measure
% nc: Number of controlers
%global z0 x0 u0 T J m n uu Sp rule qsw;
%global Sp;
in = nargin;

Jspan = 200;
J = Jspan;
JSPAN = [0 Jspan];

[nSP nc n2] = size(SpX);
nc = length(controlers);
ifig = 1;
% for iSP = 1:nSP
    for ic = 1:nc
        if in==1
            figure(ifig);
        elseif in>=2
            figure(FigIn)
        end
        clf        
        ifig = ifig+1;
        Sp{1,1} = SpX{controlers(ic).q,controlers(ic).idController,1};
        Sp{1,2} = SpX{controlers(ic).q,controlers(ic).idController,2};
        iniSp = 1;
        T = sum(Sp{1,2})-0;
        TSPAN = [0 sum(Sp{1,2})];
        
        xini = Sp{iniSp,1}(:,iniSp);
        
        x0 = [0;controlers(ic).q;1;xini;0];
        u0 = [0;controlers(ic).q;1;xini;0];
        uu = u0';
        z0 = [x0; u0];
        n = length(x0); %# of state components
        m = length(u0); %# of input components
        
        % simulation horizon
        % rule for jumps
        % rule = 1 -> priority for jumps
        % rule = 2 -> priority for flows
        % rule = 3 -> no priority, random selection when simultaneous conditions
        rule = 1;
        % constants
      %  global  m n;
        n = length(x0); %# of state components
        m = length(u0); %# of input components
        %% simulate
        try
            [t x j] = hybridsolver(@f,@g,@C,@D,z0,TSPAN,JSPAN,rule);
        catch ME
        end
        %%
        % plot solution
        x = squeeze(x);
        subplot(2,1,1),plot(t,x(:,1))
        grid on
        str = sprintf('Evolution of the internal clock of the IMATIC controller. SP#%d',controlers(ic).q);
        title(str)
        xlabel('time')
        ylabel('\tau')
        subplot(2,1,2), hold on
        for ij=0:1:j(end)
            iij = find(j==ij,1,'first');
            fij = find(j==ij,1,'last');
            for iph = 1:length(x0)-4;
                switch x(iij,3+iph)
                    case 1 % RA
                        plot([t(iij),t(fij)],[iph,iph],'--y','LineWidth',4)
                        plot([t(iij),t(fij)],[iph+(0.1),iph+(0.1)],'--r','LineWidth',4)
                    case 2 % V
                        plot([t(iij),t(fij)],[iph,iph],'g','LineWidth',4)
                    case 3 % Vint
                        plot([t(iij),t(fij)],[iph,iph],'--g','LineWidth',4)
                        plot([t(iij),t(fij)],[iph+(0.1),iph+(0.1)],'--k','LineWidth',4)
                    case 4 % RA
                        plot([t(iij),t(fij)],[iph,iph],'y','LineWidth',4)
                    case 5 % RA
                        plot([t(iij),t(fij)],[iph,iph],'r','LineWidth',4)
                end
            end          
        end
        if in == 3
            taoTotal = sum(controlers(ic).SP{2}(1:controlers(ic).sigma-1));
            ytaoVec = (controlers(ic).tao+taoTotal).*ones(1,2);
            xtaoVec = [0 iph];
            plot(ytaoVec,xtaoVec,'k')
        end
        drawnow
    end
    
% end
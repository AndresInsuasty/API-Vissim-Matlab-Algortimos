    % Calculate the signal plan (By Pablo Ñañez Ojeda)
    function Sp = GetSp(inGreen,minTao,C,orden)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Matlab M-file                Author:Pablo Ñañez
    %
    % Project: Traffic simulation
    %
    % Name: GetSp.m
    %
    %
    % Version: 0.1
    % Required files: -
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % constants
    % minTao Case 1 (phases 1 2 4 5 - RA V A R)
    % minTao{phase}([]) = [minRA TV minAmb -1]
    % minTao Case 2 (phases 2 3 5 - V Vint R)
    % minTao{phase}([]) = [TV minVint -1]
    Sp1 = zeros (length(inGreen),C);
    for iph = 1:length(inGreen)
        Sp1 = circshift(Sp1,[0 -(inGreen(iph)-1)]);
        minTao{iph}(end) = C - sum(minTao{iph}(1:end-1));
        it = 1;
        for iSp = 1:length(minTao{iph})
            Sp1(iph,it:it-1+minTao{iph}(iSp))= orden{iph}(iSp); % state
            it = it+minTao{iph}(iSp);
        end
        Sp1 = circshift(Sp1,[0 +(inGreen(iph)-1)]);
    end
    Sp2 = [];
    Sp{1}(:,1) = Sp1(:,1);
    Sp{2}(1) = 2;
    for it = 1:C-1;
        if sum(Sp1(:,it)==Sp1(:,it+1))==length(inGreen)
            Sp{1}(:,end) = Sp1(:,it);
            Sp{2}(end) = Sp{2}(end)+1;
        else
            Sp{1}(:,end+1) = Sp1(:,it+1);
            Sp{2}(end+1) = 1;
        end
    end
    Sp{2}(end) = Sp{2}(end)-1;

    end

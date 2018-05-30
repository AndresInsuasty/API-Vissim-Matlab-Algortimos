%% -------------------------------------------------------------------------
% getWspace.m
% -------------------------------------------------------------------------
% Calculate a basis of the space \omega^* for some matrices E and A
% By Pablo Ñañez
% Based on the work of Stephan Trenn
% Universidad de los Andes
% Bogotá, Colombia
% March 31, 2011
% -------------------------------------------------------------------------

function W = getWspace(E,A)
[m,n] = size(E);
if m==n && sum(size(E)==size(A))==2
    W = sym(zeros(n,1));
    oldsize = -1;
    newsize = 0;
    while newsize~=oldsize
        try ez = (A*W==sym(zeros(n,1))); catch ez=isempty(A*W); end
        if ez
            AW = sym(zeros(n,0));
        else
            AW = colspace(A*W);
        end
        W = getPreImage(E,AW);
        oldsize = newsize;
        newsize = rank(W);
    end
else
    error('Both matrices must be square and of the same size')
end
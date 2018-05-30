%% -------------------------------------------------------------------------
% getWspaceTn.m
% -------------------------------------------------------------------------
% Calculate a basis of the space \omega^* for some matrices E and A
% By Pablo Ñañez
% Based on the work of Stephan Trenn
% Universidad de los Andes
% Bogotá, Colombia
% March 31, 2011
% -------------------------------------------------------------------------

function W = getWspaceTn(E,A)
[m,n] = size(E);
if m==n && sum(size(E)==size(A))==2
    W = (zeros(n,1));
    oldsize = -1;
    newsize = 0;
    while newsize~=oldsize
        AW = colspace(A*W);
        W = getPreImageTn(E,AW);
        oldsize = newsize;
        newsize = rank(W);
    end
else
    error('Both matrices must be square and of the same size')
end
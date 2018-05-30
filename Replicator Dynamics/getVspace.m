%% -------------------------------------------------------------------------
% getVspace.m
% -------------------------------------------------------------------------
% Calculate a basis of the space \nu^* for some matrices E and A
% By Pablo Ñañez
% Based on the work of Stephan Trenn
% Universidad de los Andes
% Bogotá, Colombia
% March 31, 2011
% -------------------------------------------------------------------------

function V = getVspace(E,A)
[m,n] = size(E);
if m==n && sum(size(E)==size(A))==2
    V = eye(n);
    oldsize = -1;
    newsize = m;
    while newsize~=oldsize
        EV = colspace(E*V);
        V = getPreImage(A,EV);
        oldsize = newsize;
        newsize = rank(V);
    end
else
    error('Both matrices must be square and of the same size')
end
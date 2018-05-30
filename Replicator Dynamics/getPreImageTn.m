%% -------------------------------------------------------------------------
% getPreImageTn.m
% -------------------------------------------------------------------------
% Calculate a basis of the preimage A^{-1}(im S) for some matrices A and S
% By Pablo Ñañez
% Based on the work of Stephan Trenn
% Universidad de los Andes
% Bogotá, Colombia
% March 31, 2011
% -------------------------------------------------------------------------

function V = getPreImageTn(A,S)
[m1,n1] = size(A); [m2,n2] = size(S);
if m1==m2 || m2==0
    H = null([A,S]);
    if isempty(H) 
        V = sym(zeros(n1,0));
    else
        V = colspace(H(1:n1,:));
    end
else
    error('Both matrices must have same number of rows')
end
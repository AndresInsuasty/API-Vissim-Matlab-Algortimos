function dpdt = replicatorsWDS_ode(t,p,flag,P,alpha,ka,Nj)
beta = 1;
epsilon = 0.01;
%calculo de f_i
f_13 = P(end);
for i=1:Nj
    f(i)= P(i)/(p(i)+epsilon)*alpha;
    f_bari(i)=p(i)*f(i);
end
f_bar=sum(f_bari);
for i=1:Nj
    dpdt(i,1)=beta*p(i)*(f(i)-f_bar);
end
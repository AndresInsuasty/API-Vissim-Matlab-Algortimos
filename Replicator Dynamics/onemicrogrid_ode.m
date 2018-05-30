function dpdt = onemicrogrid_ode(t,p,flag,P,ka,r,Nj)
beta = 1;
%calculo de f_i
for i=1:Nj
    f(i)=r(i)*(1-P*p(i)/ka(i));
    %f(i)=r(i)*(1-p(i)/ka(i));
    %f(i)=(2-1/r(i))*(1-p(i)*P/ka(i));
    f_bari(i)=p(i)*f(i);
end
%cálculo de f_bar
f_bar=sum(f_bari);
%f_bar=1/P*sum(f_bari);
%campo vectorial rd
for i=1:Nj
    dpdt(i,1)=beta*p(i)*(f(i)-f_bar);
end
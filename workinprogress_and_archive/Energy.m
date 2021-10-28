function I = Energy(x,a,b,u,du,v,dv)
I1 = du-dv;
I1 = I1.^2;

I2 = u-v;
I2 = I2.^2;

alpha = arrayfun(a,x);
beta = arrayfun(b,x);

I1 = alpha.*I1;
I2 = beta.*I2;

K = trapz(x,I1+I2);

I = sqrt(K);
end
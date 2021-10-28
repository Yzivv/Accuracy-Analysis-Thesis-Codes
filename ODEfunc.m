function [fnc, deriv] = ODEfunc(a,b,f,xs,y)
    function g = func(x)
        k = ceil((length(xs)-1)*interp1(xs,xs,x+realmin,'next')); % realmin added so we never get 0 index
        g = y(2*k-1)*exp(sqrt(b(k)/a(k))*x)+y(2*k)*exp(-sqrt(b(k)/a(k))*x)-f(k)/b(k);
    end
    function d = der(x)
        k = ceil((length(xs)-1)*interp1(xs,xs,x+realmin,'next'));
        d = sqrt(b(k)/a(k))*y(2*k-1)*exp(sqrt(b(k)/a(k))*x)-sqrt(b(k)/a(k))*y(2*k)*exp(-sqrt(b(k)/a(k))*x);
    end
    fnc = @func;
    deriv = @der;
end
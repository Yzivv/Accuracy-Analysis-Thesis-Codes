%% ODEfuncdefiner vectorized version

%% Creates the function handle from the coefficients y = A\b
%% which are received from the function
%% LinearPieceODEcoeffSolver.m

%% The functions are vectorized so you can evaluate on vectors

function [fnc, deriv] = vectorizedODEfuncdefiner(c1,c2,a,b,f)
    function g = func(x)
        g = c1*exp(sqrt(b/a).*x)+c2*exp(-sqrt(b/a).*x)-f/b;
    end
    function d = der(x)
        d = sqrt(b/a)*c1*exp(sqrt(b/a).*x)-sqrt(b/a)*c2*exp(-sqrt(b/a).*x);
    end
    fnc = @func;
    deriv = @der;
end
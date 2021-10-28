%% Solves a linear system of equations related to an ODE with piecewise constant coefficients
%% of the form 
%% au'' - bu = f, where a = [a1,...,an], b = [b1,...,bn], f = [f1,...,fn]
%% are constants in each subinterval of x = [x0,x1,...,xn]. Assume also x0 = 0 and xn = 1 ##TODO generalize to nonzero
%% The function returns A, d from which y = A\d has the coefficients ck of
%% u(x) =  ck1*e^(b/a)^0.5 + ck2e^(b/a)^0.5 - f/a
%% ------
%% INPUT
%% ------
%% interval_points = [x0,...,xn] : The subinterval partition points
%% a = [a1,...,an] : Constant values of a in each subinterval
%% b = [b1,...,bn] : Constant values of b in each subinterval
%% f = [f1,...,fn] : Constant values of f in each subinterval
%% bdcond = [bd1, bd2] : the boundary conditions of the ODE
%% ------
%% OUTPUT
%% ------
%% A, d = the matrix and vector from which the coefficients required
%% to construct the function u(x) can be found.

function [out1, out2] = LinearPieceODEcoeffSolver(a,b,f,interval_points,bdcond)
    
    x = interval_points(2:end); %% Taking the first point out since we assume x0 = 0
    
    %% initialize matrix A and vector d
    n = length(a);
    A = zeros(2*n);
    d = zeros(2*n,1);
    
    %% helping notation define h(k) = (b(k)/a(k))^0.5
    h = (b./a).^0.5;
    
    %% Boundary equations
    A(1,1:2) = 1; %% on x0 = 0 the boundary equation becomes c11+c12 = f1/b1 + bcdcond(1)
    d(1) = f(1)/b(1) + bdcond(1);
    
    A(2*n, (2*n-1):2*n) = [exp(h(n)*x(end)), exp(-h(n)*x(end))];
    d(end) = f(end)/b(end) + bdcond(2);
    
    %% Equations from u1(x1) = u2(x1), ..., u_n-1(x_n-1) = un(xn_n-1)
    %% c11*e^()+c12*e^(-)-c21*e^()-c22*e^(-)
    %% And from uj'(xj) = uj+1'(xj)
    t = 2;
    while t < 2*n
        i = t/2;
        A(t,t-1:t+2) = [exp(h(i)*x(i)), exp(-h(i)*x(i)), -exp(h(i+1)*x(i)), -exp(-h(i+1)*x(i))];
        A(t+1,t-1:t+2) = [h(i)*exp(h(i)*x(i)), -h(i)*exp(-h(i)*x(i)), -h(i+1)*exp(h(i+1)*x(i)), h(i+1)*exp(-h(i+1)*x(i))];
        d(t) = f(i)/b(i) - f(i+1)/b(i+1);
        t = t + 2;
    end
    
    out1 = A;
    out2 = d;
end
%% Solver for linear differential equation with piecewise constant coefficients.
%% au'' = f, where a = [a1,a2,...,an] and f = [f1,f2,...fn] which are constants
%% in intervals Ik = [x_k,x_k+1]. The endpoints are always 0 and 1.
%% input :  interval_points = [x_0, x_1, x_2, ..., x_n]
%%          a = [a_1,a_2, ... , a_n]
%%          f = [f_1,f_2, ... , f_n]
%%          bdcond = [b_1, b_2]
%% output : the coefficient matrix A and vector b for which the functions
%%          u1, ..., un can be solved from Ay = b.

function [out1, out2] = PiecewiseSolver(interval_points, a, f, bdcond)
    x = interval_points(2:end-1);
    n = length(a);
    A = zeros(2*n);     %Creating the matrix A for Ay = b
    A(1,1) = 1;
    A(2*n, (2*n-1):2*n) = [1 1];
    h = 3;
    while h < 2*n
        A(h,h-1:h+1) = [1 0 -1];
        h = h + 2;
    end
    t = 2;
    while t < 2*n
        A(t,t-1:t+2) = [1 x(t/2) -1 -x(t/2)];
        t = t + 2;
    end
    b = zeros(2*n,1);   %Creating coefficient b for Ay = b
    b(1) = bdcond(1);
    b(end) = bdcond(2)-f(end)/(2*a(end));
    
    g = 2;
    while g < 2*n
        i = g/2;
        b(g) = x(i)^2*(f(i+1)/(2*a(i+1))-f(i)/(2*a(i)));
        g = g+2;
    end
    d = 3;
    while d < 2*n
        i = (d-1)/2;
        b(d) = x(i)*(f(i+1)/a(i+1) - f(i)/a(i));
        d = d + 2;
    end
    out1 = A;
    out2 = b;
    
    
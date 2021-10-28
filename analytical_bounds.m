%% Calculates the analytical upper bounds and the analytical lower bound
%% of a given piecewise constant coefficient problem
%%
%% INPUT:
%%      a_mean = mean function alpha
%%      b_mean = mean function beta
%%      f_mean = mean function f
%%      delta = values of delta in each subinterval
%%      gamma = values of gamma in each subinterval
%%      epsil = values of epsilon in each subinterval
%%      x = [x_0, ... , x_n] subinterval partition points
%%      bdcond = boundary conditions of the system
%% OUTPUT:
%%      [low, up1, up2] = lower bound and upper bounds

function [low, up_M1, up_M2] = analytical_bounds(a_mean,b_mean,f_mean,delta,gamma,epsil,x,bdcond)
    
    n = length(delta);
    a = x(1);
    b = x(end);
    
    
    %% Calculating the constants K
    
    a_min = a_mean - delta;
    b_min = b_mean - gamma;
    
    d1 = delta./a_min;
    d2 = gamma./b_min;
    
    K_low = sqrt(1-max([max(d1), max(d2)]));
    K_up = sqrt(1+max([max(d1), max(d2)]));
    
    %% Solving the mean problem
    [u, du] = SolverPieceConst(a_mean,b_mean,f_mean,linspace(a,b,length(a_mean)+1),bdcond);
    
    %% Making a spline of the mean solution func and derivative
    xx = linspace(a,b,100);
    y1 = arrayfun(u,xx);
    y2 = arrayfun(du,xx);
    u_s = spline(xx,y1);
    du_s = spline(xx,y2);
    
    %% Calculating the lower bound
    
    numerator = 0;
    denominator = 0;
    
    for k = 1:n
        up_func = @(x) delta(k)*ppval(du_s,x).^2 + gamma(k)*ppval(u_s,x).^2 + abs(epsil(k)*ppval(u_s,x));
        do_func = @(x) a_mean(k)*ppval(du_s,x).^2 + b_mean(k)*ppval(u_s,x).^2 - delta(k)*ppval(du_s,x).^2 - gamma(k)*ppval(u_s,x).^2;
        numerator = numerator + integral(up_func,x(k),x(k+1));
        denominator = denominator + integral(do_func,x(k),x(k+1));
    end
    
    denominator = sqrt(denominator);
    
    low = K_low*(numerator/denominator);
    
    %% Calculating upper bound for M1
    
    int = 0;
    
    for k = 1:n
        func = @(x) (delta(k)^2/a_min(k))*ppval(du_s,x).^2 + (1/(b_min(k)-gamma(k)))*(epsil(k)+gamma(k)*abs(ppval(u_s,x))).^2;
        int = int + integral(func,x(k),x(k+1));
    end
    
    int = sqrt(int);
    
    up_M1 = 2*K_up*int;
    
    %% Calculating upper bound for M2
    
    int = 0;
    
    Cf2 = ((b-a)/pi)*(1/min(a_min));
    Cf = ((b-a)/pi)*sqrt(1/min(a_min));
        
    int1 = 0;
    int2 = 0;
    
    for k = 1:n
        func1 = @(x) (delta(k)^2*ppval(du_s,x).^2)/(a_min(k));
        func2 = @(x) (gamma(k)*abs(ppval(u_s,x)) + epsil(k)).^2;
        int1 = int1 + integral(func1,x(k),x(k+1));
        int2 = int2 + integral(func2,x(k),x(k+1));
    end
    
    int1 = sqrt(int1);
    int2 = Cf*sqrt(int2);
    int = int1 + int2;
    
    up_M2 = 2*K_up*int;
    
end













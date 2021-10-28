%% Calculates the Upper bound of the diameter related to a piecewise constant
%% coefficient problem. 
%%
%% INPUT:
%%      a_mean = mean function alpha
%%      b_mean = mean function beta
%%      f_mean = mean function f
%%      deltamax = max value of delta
%%      gammamax = max value of gamma
%%      epsilmax = max value of epsilon
%%      domain = [a,b] the start and end point of domain
%%      bdcond = boundary conditions of the system
%% OUTPUT:
%%      analytical upper bound of the diameter

function out = D1_upper(a_mean, b_mean, f_mean, deltamax, gammamax, epsilmax, domain, bdcond)
    
    a_min = min(a_mean)-deltamax;
    b_min = min(b_mean)-gammamax;
    
    a = domain(1);
    b = domain(2);
    
    K = 1 + max([deltamax/a_min, gammamax/b_min]);
    
    Cf = ((b-a)/pi)*(1/a_min);
    
    [u, du] = SolverPieceConst(a_mean,b_mean,f_mean,linspace(a,b,length(a_mean)+1),bdcond);
    
    x = linspace(a,b,61);
    y1 = arrayfun(u,x);
    y2 = arrayfun(du,x);
    u_spline = spline(x,y1);
    du_spline = spline(x,y2);
    
    r = sqrt(K)*((deltamax/sqrt(a_min))*L2norm(du_spline)+Cf*(gammamax*L2norm(u_spline)+epsilmax*sqrt(b-a)));
    
    out = 2*r;
end
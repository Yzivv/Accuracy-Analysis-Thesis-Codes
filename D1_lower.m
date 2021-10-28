%% Calculates the LOWER bound of the diameter related to a piecewise constant
%% coefficient problem. 
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
%%      analytical lower bound of the diameter

function out = D1_lower(a_mean, b_mean, f_mean, delta, gamma, epsil, x, bdcond)
    
    n = length(delta);
    a_min = a_mean-delta;
    b_min = b_mean-gamma;
    
    d1 = max(delta./a_min);
    d2 = max(gamma./b_min);
    
    K = sqrt(1 - max([d1, d2]));
    
    a = x(1);
    b = x(end);
    %% Solving the mean problem
    [u, du] = SolverPieceConst(a_mean,b_mean,f_mean,linspace(a,b,length(a_mean)+1),bdcond);
    
    xx = linspace(a,b,61);
    y1 = arrayfun(u,xx);
    y2 = arrayfun(du,xx);
    u_spline = spline(xx,y1);
    du_spline = spline(xx,y2);
    
    ucnew = zeros(n,7);
    ducnew = zeros(n,7);
    ucoefs = u_spline.coefs;
    ducoefs = du_spline.coefs;
    N = length(u_spline.breaks)-1;

    %for i = 1:N
    %    ucnew(i,:) = conv(ucoefs(i,:),ucoefs(i,:));
    %    ducnew(i,:) = conv(ducoefs(i,:),ducoefs(i,:));
    %end

    a_mean_extended = repelem(a_mean,15);
    b_mean_extended = repelem(b_mean,15);
    
    %u_sq_spline = mkpp(u_spline.breaks,ucnew);
    %du_sq_spline = mkpp(u_spline.breaks,ducnew);
    
    
    mean_norm = energySplineSingle(u_spline.breaks,u_spline,du_spline,a_mean_extended,b_mean_extended);
    
    upstairs = 0;
    downstairs = mean_norm^2;
    
    for k=1:n
        %Itest1 = delta(k)*quadgk(@(t) ppval(du_sq_spline,t),x(k),x(k+1));
        %Itest2 = gamma(k)*quadgk(@(t) ppval(u_sq_spline,t),x(k),x(k+1));
        %Itest3 = epsil(k)*quadgk(@(t)ppval(u_sq_spline,t),x(k),x(k+1);
        I1 = delta(k)*integral(@(t) (ppval(du_spline,t)).^2,x(k),x(k+1));
        I2 = gamma(k)*integral(@(t) (ppval(u_spline,t)).^2,x(k),x(k+1));
        I3 = epsil(k)*integral(@(t) abs((ppval(u_spline,t))),x(k),x(k+1));
        upstairs = upstairs + I1 + I2 + I3;
        downstairs = downstairs - I1 - I2;
    end
     
    %upstairs = deltamax*L2norm(du_spline)^2+gammamax*L2norm(u_spline)^2+epsilmax*L1norm(u_spline);
    %downstairs = mean_norm^2-deltamax*L2norm(du_spline)^2-gammamax*L2norm(u_spline)^2;
    
    r = K*(upstairs/sqrt(downstairs));
    
    out = r;
end
%% Calculates the upper bound of diameter of a piecewise constant solution cloud.
%% Uses the error majorant M1.
%%
%% INPUT:
%%      a_mean = mean function alpha values in each subinterval
%%      b_mean = mean function beta values in each subinterval
%%      f_mean = mean function f values in each subinterval
%%      delta = values of delta in each subinterval
%%      gamma = values of gamma in each subinterval
%%      epsil = values of epsilon in each subinterval
%%      x = [x_0, ... , x_n] subinterval partition points
%%      bdcond = boundary conditions of the system
%% OUTPUT:
%%      analytical upper bound of the diameter

function upper_bound = D1_upper_piece_M1(a_mean, b_mean, f_mean, delta, gamma, epsil, x, bdcond)
    
    n = length(delta);
    a_min = a_mean-delta;
    b_min = b_mean-gamma;
    
    d1 = max(delta./a_min);
    d2 = max(gamma./b_min);
    
    K = 1 + max([d1, d2]);

    a = x(1);
    b = x(end);
   
    %% Solving the mean problem
    [u, du] = SolverPieceConst(a_mean,b_mean,f_mean,linspace(a,b,length(a_mean)+1),bdcond);
    
    xx = linspace(a,b,61);
    y1 = arrayfun(u,xx);
    y2 = arrayfun(du,xx);
    u_spline = spline(xx,y1);
    du_spline = spline(xx,y2);
    
    first_term = 0;
    second_term = 0;
    
    for k=1:n
        first_term = first_term + delta(k)^2*integral(@(t) ppval(du_spline,t).^2,x(k),x(k+1))/(a_mean(k)-delta(k));
        second_term = second_term + (integral(@(t) (gamma(k)*abs((ppval(u_spline,t))+epsil(k))).^2,x(k),x(k+1)))/(b_mean(k)-gamma(k));
    end
    
    
    r = sqrt(K*(first_term + second_term));
    
    upper_bound = 2*r;
end
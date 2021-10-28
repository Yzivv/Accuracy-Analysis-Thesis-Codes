%% Generates a training example with the given possible indeterminacies for the
%% linear case au'' - bu = f.
%% The coefficients have a range of possible mean coefficients and a range
%% of possible deviations from the mean solutions.
%%
%% INPUT:
%%      a_mean = [a_1, a_2, ... , a_n] the value of mean alpha in each interval
%%      b_mean = -----||-----
%%      f_mean = -----||-----
%%      delta = max deviation from a_mean of random alpha in each interval
%%      gamma = max deviation from b_mean of random beta in each interval
%%      epsil = max deviation from f_mean of random f in each interval
%%      x = [x_0, ... , x_n] subinterval partition points
%%      looking_points = [l_1,l_2,...,l_t] given points for which the strip is "looked" at
%%      sol_intervals = amount of splits done inside each subdomain for possible solutions
%%      func_amount = how many functions are used to approximate the energy size of cloud
%%      bdcond = boundary condition of the ODE
%% OUTPUT:
%%      [I,I_mat] = the maximum energy distance found and the matrix of all distances.
%%                  Output of the neural network is trained towards I
%%      [look, value] = the looking_points and values of min and max values of the coefficients.
%%                      Input of the neural network will be the array of [value]
%%      upperbound = the analytical upperbound of the diameter
%%      lowerbound = the analytical lowerbound of the diameter 
function [I,I_mat,look,value,up_bound,up_bound2,low_bound] = TrainExample2(a_mean,b_mean,f_mean,delta,gamma,epsil,x,looking_points,sol_intervals,func_amount,bdcond)
    
    n = length(x)-1;
    %% Initializing the indeterminacy interval values
    a = zeros(n,2);
    b = zeros(n,2);
    f = zeros(n,2);
    
    %% Setting the indeterminacy values as [a_mean-delta, a_mean + delta]
    %% in each subinterval for a,b and f.
    
    a(:,1) = a_mean-delta;
    a(:,2) = a_mean+delta;
    b(:,1) = b_mean-gamma;
    b(:,2) = b_mean+gamma;
    f(:,1) = f_mean-epsil;
    f(:,2) = f_mean+epsil;
    
    %% Creating a set of possible solutions with random coefficient values
    
    [u_cells, du_cells] = SetPieceConst2(a,b,f,x,sol_intervals,func_amount,bdcond);
    %PlotSet(u_cells,linspace(0,1),'no');
    %% Turning the examples into spline functions for integration.
    %% Here using 100 piece fit which is very accurate. Input is 101 so that we have 100 pieces.
    [u_splines, du_splines] = splinecells(u_cells,du_cells,101);
    breaks = u_splines{1}.breaks;
    
    %% Brute force calculation of the maximum energy distance in the solution cloud
    
    am = a_mean;
    bm = b_mean;
    
    extension_number = 100/n;
    a_mean_extended = repelem(am,extension_number);
    b_mean_extended = repelem(bm,extension_number);
    [I,I_mat] = MaxEnergySpline2(breaks,u_splines,du_splines,a_mean_extended,b_mean_extended);

    %% Setting the values of the max and min coefficient functions at the looking points
    
    look = looking_points;
    value = FindValsConst(a,b,f,x,look);
    
    [low, up_1, up_2] = analytical_bounds(a_mean,b_mean,f_mean,delta,gamma,epsil,x,bdcond);
    low_bound = low;
    up_bound = up_1;
    up_bound2 = up_2;
    
end

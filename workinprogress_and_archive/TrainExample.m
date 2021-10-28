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
%%      func_amount = how many functions are used to approximate the energy size of cloud
%%      bdcond = boundary condition of the ODE
%% OUTPUT:
%%      [I,I_mat] = the maximum energy distance found and the matrix of all distances.
%%                  Output of the neural network is trained towards I
%%      [look, value] = the looking_points and values of min and max values of the coefficients.
%%                      Input of the neural network will be the array of [value]

function [I,I_mat,look,value] = TrainExample(a_mean,b_mean,f_mean,delta,gamma,epsil,x,looking_points,func_amount,bdcond)
    
    n = length(a_mean);
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
    
    [u_cells, du_cells] = SetPieceConst(a,b,f,x,bdcond,func_amount);
    
    %% Brute force calculation of the maximum energy distance in the solution cloud
    
    [I, I_mat] = FindMaxEnergyDistance(linspace(0,1,30),u_cells,du_cells);
    
    %% Setting the values of the max and min coefficient functions at the looking points
    
    look = looking_points;
    value = FindValsConst(a,b,f,x,look);
    
end


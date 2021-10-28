%% Generates a set of different function handles with given indeterminacy
%% parameters. The coefficient functions used will be piecewise constant.
%% 
%% INPUT:
%%      ai,bi,fi = [a11, a12; ... ; an1,an2] matrix with the indeterminacy intervals in each subinterval
%%      x = the subinterval partition points [x0,...,xn]
%%      bdcond = boundary condition of the ode
%%      func_amount = how many functions will be created
%%
%% OUTPUT:
%%      u_cells, du_cells = the functions generated and their derivatives
%%                          as function handles in a cell array.


function [u_cells, du_cells] = SetPieceConst(ai, bi, fi, x, bdcond, func_amount)
    
    %% Initializing the cell arrays of the functions and derivatives
    u_cells = cell(func_amount,1);
    du_cells = cell(func_amount,1);
    
    intervals = length(ai);
    
    %% Initialize the indeterminacy coefficient arrays
    a = zeros(func_amount,intervals);
    b = zeros(func_amount,intervals);
    f = zeros(func_amount,intervals);
    
    %% For each subinterval make a random number in the related indeterminacy interval
    %% and also do this for func_amount rows
    for k=1:intervals
        a(:,k) = (ai(k,2)-ai(k,1)).*rand(func_amount,1) + ai(k,1);
        b(:,k) = (bi(k,2)-bi(k,1)).*rand(func_amount,1) + bi(k,1);
        f(:,k) = (fi(k,2)-fi(k,1)).*rand(func_amount,1) + fi(k,1);
    end
       
    %% Creating func_amount number of different solutions 
    for k=1:func_amount
        [u_cells{k}, du_cells{k}] = SolverPieceConst(a(k,:),b(k,:),f(k,:),x,bdcond);
    end
end
    
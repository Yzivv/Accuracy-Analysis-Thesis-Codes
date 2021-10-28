%% Generates a set of different function handles with given indeterminacy
%% parameters. The coefficient functions used will be piecewise constant.
%% 
%% Two different sets are made, one of them has completely random coefficients
%% and the other one has coefficients taken from the extremes of the range.
%% INPUT:
%%      ai = [a11, a12; ... ; an1,an2] matrix with the indeterminacy intervals in each subinterval
%%      bi = ----||----
%%      fi = ----||----
%%      x = the subinterval partition points [x0,...,xn]
%%      bdcond = boundary condition of the ode
%%      func_amount = how many functions will be created
%%
%% OUTPUT:
%%      u_cells, du_cells = the functions generated and their derivatives
%%                          as function handles in a cell array.


function [u_cells, du_cells] = SetPieceConst2(ai, bi, fi, x, sol_intervals,func_amount,bdcond)
    %%%%%%%
    %% Making the completely random possible solutions for func_amount different coefs
    %%%%%%%
    %% Initializing the cell arrays of the functions and derivatives
    u_cells = cell(3*func_amount,1);
    du_cells = cell(3*func_amount,1);
    
    intervals = length(x)-1;
    
    %% Initialize the indeterminacy coefficient arrays
    a = zeros(func_amount,sol_intervals*intervals);
    b = zeros(func_amount,sol_intervals*intervals);
    f = zeros(func_amount,sol_intervals*intervals);
    
    %% For each subinterval make a random number in the related indeterminacy interval
    %% and also do this for func_amount rows
    
    for k=1:intervals
        a(:,(sol_intervals*(k-1)+1):(sol_intervals*k)) = (ai(k,2)-ai(k,1)).*rand(func_amount,sol_intervals) + ai(k,1);
        b(:,(sol_intervals*(k-1)+1):(sol_intervals*k)) = (bi(k,2)-bi(k,1)).*rand(func_amount,sol_intervals) + bi(k,1);
        f(:,(sol_intervals*(k-1)+1):(sol_intervals*k)) = (fi(k,2)-fi(k,1)).*rand(func_amount,sol_intervals) + fi(k,1);
    end
       
    %% Creating func_amount number of different solutions 
    for k=1:func_amount
        [u_cells{k}, du_cells{k}] = SolverPieceConst(a(k,:),b(k,:),f(k,:),linspace(0,1,intervals*sol_intervals+1),bdcond);
    end
    
    %%%%%%%
    %% Making the solutions with only high values of indeterminacies
    %%%%%%%
    a2 = zeros(func_amount,sol_intervals*intervals);
    b2 = zeros(func_amount,sol_intervals*intervals);
    f2 = zeros(func_amount,sol_intervals*intervals);
    
    for k=1:intervals
        a2(:,(sol_intervals*(k-1)+1):(sol_intervals*k)) = (ai(k,2)-ai(k,1)).*(randi(2,func_amount,sol_intervals)-1) + ai(k,1);
        b2(:,(sol_intervals*(k-1)+1):(sol_intervals*k)) = (bi(k,2)-bi(k,1)).*(randi(2,func_amount,sol_intervals)-1) + bi(k,1);
        f2(:,(sol_intervals*(k-1)+1):(sol_intervals*k)) = (fi(k,2)-fi(k,1)).*(randi(2,func_amount,sol_intervals)-1) + fi(k,1);
    end
    
    %% Creating the solutions again
    for k=1:func_amount
        H = k+func_amount;
        [u_cells{H},du_cells{H}] = SolverPieceConst(a2(k,:),b2(k,:),f2(k,:),linspace(0,1,intervals*sol_intervals+1),bdcond);
    end
    
    %%%%%%%
    %% Making more solutions with clear maximum coefs. using sol_intervals = 1
    %%%%%%%
    
    a3 = zeros(func_amount,intervals);
    b3 = zeros(func_amount,intervals);
    f3 = zeros(func_amount,intervals);
    
    for k=1:intervals
        a3(:,k) = (ai(k,2)-ai(k,1)).*(randi(2,func_amount,1)-1) + ai(k,1);
        b3(:,k) = (bi(k,2)-bi(k,1)).*(randi(2,func_amount,1)-1) + bi(k,1);
        f3(:,k) = (fi(k,2)-fi(k,1)).*(randi(2,func_amount,1)-1) + fi(k,1);
    end
    
    for k=1:func_amount
        H = k+2*func_amount;
        [u_cells{H}, du_cells{H}] = SolverPieceConst(a3(k,:),b3(k,:),f3(k,:),linspace(0,1,intervals+1),bdcond);
    end
    
end



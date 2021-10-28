%% Solves a differential equation of the form
%% au'' - bu = f 
%% with constant coefficients 
%% a = [a1,a2,...,an], b = [b1,b2,...,bn], f = [f1,f2,...,fn]
%% in subintervals [x0,x1], ... , [xn-1, xn].
%% Returns the solution function u and its derivative du.
%% 
%% INPUT:
%%      a,b,f = coefficients as arrays of the constant values in each subinterval
%%      x = the subinterval partition points e.g [0,0.5,1] if there are 2 intervals.
%%      bdcond = boundary conditions of the ode, usually [0,0]
%% OUTPUT:
%%      u, du = the function and its derivative as a function handle

function [u, du] = SolverPieceConst(a,b,f,x,bdcond)
    [A, D] = LinearPieceODEcoeffSolver(a,b,f,x,bdcond);
    y = A\D;
    [u, du] = ODEfunc(a,b,f,x,y);
end
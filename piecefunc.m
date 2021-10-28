%% Makes a piecewise constant polynomial struct from a given array of values
%% INPUT:
%%      vals = [v1,v2,...,vn] values of the piecewise function in each subinterval
%%      breaks = linspace(a,b,n+1) the breakpoints between intervals
%% OUTPUT:
%%      piece = the polynomial struct of the piecewise poly

function piece = piecefunc(vals,breaks)
    
    coefs = transpose(vals);
    piece = mkpp(breaks,coefs);
    
end
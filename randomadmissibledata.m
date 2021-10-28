%% Creates a random spline function handle on given number of interpolation points.
%% Also makes indeterminacy function handles which are not constants
%% INPUT:
%%      points : how many interpolation points the spline has
%%      range : [h,H] the range in which the polynomial values must be
%%      domain : what is the domain of our polynomial
%%      max_indeterminacy : how many percent the indeterminacy can differ from mean
%%      indeterminacy_points : number of splits in domain
%% OUTPUT:
%%      spl : a function handle to the created spline polynomial

function [mean_func, indeterminacy_func, mean_der] = randomadmissibledata(points,range,domain,max_indeterminacy,indeterminacy_points)
    
    spline_points = rand(1,points)*(range(2)-range(1))+range(1);
    pp = spline(linspace(domain(1),domain(2),points),spline_points);
    
    mean_func = @(x) ppval(pp,x);
    min_mean = mean_func(fminbnd(mean_func,domain(1),domain(2)));
    
    delta = rand(1,indeterminacy_points)*max_indeterminacy*min_mean;
    
    piece_func = piecefunc(delta,linspace(domain(1),domain(2),indeterminacy_points+1));
    indeterminacy_func = @(x) ppval(piece_func,x);
    
    der_pp=fnder(pp,1);
    mean_der=@(x) ppval(der_pp,x);
    
end

    
    
    
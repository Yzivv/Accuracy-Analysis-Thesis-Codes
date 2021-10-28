%% Creates a random spline function handle on given number of interpolation points.
%% Also makes indeterminacy function handles.
%% INPUT:
%%      mean_points : how many interpolation points the mean spline has
%%      mean_range : [h,H] the range in which the mean polynomial values must be
%%      domain : what is the domain of our polynomial
%%      max_indeterminacy : how many percent the indeterminacy can differ from mean
%%      indeterminacy_points : how many interpolation points the indeterminacy spline has
%% OUTPUT:
%%      mean_func : a function handle to the created spline polynomial
%%      indeterminacy_func : function handle to the constant function
%%      mean_der : function handle to the mean functions derivative

function [mean_func, indeterminacy_func, mean_der] = randomspline(mean_points,mean_range,domain,indeterminacy_range,indeterminacy_points)

    not_correct = 1;
    while not_correct == 1
        spline_points = rand(1,mean_points)*(mean_range(2)-mean_range(1))+mean_range(1);
        pp = spline(linspace(domain(1),domain(2),mean_points),spline_points);

        mean_func = @(x) ppval(pp,x);

        indeterminacy_spline_points = rand(1,indeterminacy_points)*(indeterminacy_range(2)-indeterminacy_range(1))+indeterminacy_range(1);
        delta_pp = spline(linspace(domain(1),domain(2),indeterminacy_points),indeterminacy_spline_points);

        indeterminacy_func = @(x) ppval(pp,x).*ppval(delta_pp,x);

        der_pp=fnder(pp,1);
        mean_der=@(x) ppval(der_pp,x);
        
        test_space = linspace(domain(1),domain(2),2000);
        vals = mean_func(test_space);
        if min(vals) > mean_range(1) && min(-1*vals) > -1*mean_range(2)
            not_correct = 2;
        end
    end
end

    
    
    
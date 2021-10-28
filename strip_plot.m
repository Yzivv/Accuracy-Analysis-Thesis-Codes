%% Plots a given mean function and the strip around it 
%%
%% INPUT:
%%      mean_function : function handle
%%      indeterminacy_function : function handle
%%      domain : array

function out = strip_plot(mean_function,indeterminacy_function,domain)
    
    x = linspace(domain(1),domain(2),1000);
    curve1_func = @(x) mean_function(x)-indeterminacy_function(x);
    curve2_func = @(x) mean_function(x)+indeterminacy_function(x);
    curve1 = arrayfun(curve1_func,x);
    curve2 = arrayfun(curve2_func,x);
    plot(x, curve1, 'r', 'LineWidth', 0.1);
    hold on;
    plot(x, curve2, 'r', 'LineWidth', 0.1);
    plot(x, arrayfun(mean_function,x), 'b', 'LineWidth',2);
    x2 = [x, fliplr(x)];
    inBetween = [curve1, fliplr(curve2)];
    
    fill(x2, inBetween, [153/255 204/255 1]);
    
    out = 1;

end
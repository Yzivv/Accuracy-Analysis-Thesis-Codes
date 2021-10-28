%% Plotting function for sensitivity analysis test results
%%
%% INPUT:
%%      TEST_RESULTS : N x 6 matrix with the following in each row
%%                      lower_bound, B1, B2, B3, B4, brute_force_approx, x
%%                     B1-B4 are the upper bounds
%%                     x is the variable being changed linspace
%% OUTPUT:
%%      none, just plots

function out = PlotTestResults(TEST_RESULTS,variable)
    x = TEST_RESULTS(:,7);
    
    plot(x,TEST_RESULTS(:,6),'k','LineWidth',2);
    hold on
    plot(x,TEST_RESULTS(:,1),'r--*','MarkerSize',6);
    plot(x,TEST_RESULTS(:,2),'b--*','MarkerSize',6);
    plot(x,TEST_RESULTS(:,3),'b--s','MarkerSize',7.5);
    plot(x,TEST_RESULTS(:,4),'g--*','MarkerSize',6);
    plot(x,TEST_RESULTS(:,5),'g--s','MarkerSize',7.5);
    
    xlim([x(1),x(end)]);
    
    legend({'A','B','B_1','B_2','B_3','B_4'},'Location','northwest');
    xlabel(variable) 
    ylabel('Value of bounds and Approximation')
    
    out = 1;
end
    
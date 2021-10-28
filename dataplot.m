%% Plots a given dataset with upper and lower bounds, correct approximation and network output.
%%
%% INPUT:
%%      data = [approximations; lowerbounds; upperbounds; networkoutput]
%%              when there are N examples the data matrix is a N x 4 matrix.
%%              to produce nice graph you should have sorted the data with respect to approximations.
%%              If networkoutput is not there we simply plot the other ones.
%% OUTPUT:
%%      none, just plots

function out = dataplot(data)
    
    
    n = length(data);
    x = linspace(1,n,n);
    y = transpose(data);
    y = sortrows(y);
    up_error = y(:,3) - y(:,1);
    low_error = y(:,1) - y(:,2);
    
    
    %% Comparing network input to approximation inside error bars
    figure();
    hold on
    errorbar(x,y(:,1),low_error,up_error,'b.','MarkerSize',20);
    
    net_or_not = size(data);
    
    if net_or_not(1) == 4
        plot(x,y(:,4),'ro','MarkerSize',7,'LineWidth',1.25);
        lgd = legend('Approximated true diameter and two sided analytical bounds', 'Network output');
    else
        lgd = legend('Approximated true diameter and two sided analytical bounds');
    end
    lgd.FontSize = 22;
    xlabel('Datapoint index');
    ylabel('Diameter of solution cloud');
    xlim([0,n]);
    set(gca,'FontSize',18);
    
    %% Percentual difference of network inputs to approximations
    %% Only plotted if network outputs are provided
    if net_or_not(1) == 4
        d = sortrows(abs(y(:,1)./y(:,4)-1)*100);
        figure();
        bar(x,d);
        legend('Percentage distance between approximation and network input')
    end
    out = 1;
    set(gca,'FontSize',18);

end
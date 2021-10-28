%% Plots a "dataset" where the coefficient must exist.
%% INPUT:
%%      coef = [c1,c2; c3,c4; ... ; cn-1,cn] coefficient values in subintervals
%%      x = [x0,x1,...,xn] split points of the interval
%% OUTPUT:
%%      none

function out = plotcoef(coef,x)
    n = length(coef);
    hold on
    for k=1:n
        %xx = [x(k),x(k+1)];
        %y1 = [coef(k,1),coef(k,1)];
        %y2 = [coef(k,2),coef(k,2)];
        %plot(xx,y1,'b','LineWidth',3);
        %plot(xx,y2,'b','LineWidth',3);
        rectangle('Position',[x(k) coef(k,1) (x(k+1)-x(k)) coef(k,2)-coef(k,1)],'FaceColor',[0.3010 0.7450 0.9330],'LineWidth',realmin)
    end
    out = 1;
    hold off
end
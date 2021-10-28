%% PieceODE plotter

%% Plots the function found from LinearPieceODEcoeffSolver.m

function out = piecePlot(a,b,f,y,x)
    h = 1;
    while h < length(a) + 1
        func = ODEfuncdefiner(y(2*h-1),y(2*h),a(h),b(h),f(h));
        d = linspace(x(h),x(h+1));
        k = arrayfun(func,d);
        plot(d,k);
        hold on;
        h = h+1;
    end
end
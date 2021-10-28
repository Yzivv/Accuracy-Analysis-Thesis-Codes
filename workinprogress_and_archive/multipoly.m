%% Multipolynomial plotter

function out = multipoly(a,f,y,x)
    h = 1;
    while h < length(a) + 1
        poly = Polydefiner(y(2*h-1),y(2*h),a(h),f(h));
        d = linspace(x(h),x(h+1));
        k = arrayfun(poly,d);
        plot(d,k);
        hold on;
        h = h+1;
    end
end
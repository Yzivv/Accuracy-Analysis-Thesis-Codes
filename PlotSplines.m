%% Plots all the spline-functions in a given cell array of spline-structs in one image.
%% 
%% INPUT:
%%      u_splines = the spline structs in a cell array
%%      x = the x values to use for plotting
%%      visual_type : e.g. 'r*' plots red stars, use 'no' to have all colors.
%% OUTPUT:
%%      none, plots an image

function PlotSplines(u_splines,x,visual_type)
    n = length(u_splines);
    if visual_type == 'no'
        for k=1:n
            plot(x,ppval(u_splines{k},x));
            hold on
        end
    else
        for k=1:n
            plot(x,arrayfun(u_cells{k},x),visual_type);
            hold on
        end
    end
end    
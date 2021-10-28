%% Plots all the functions in a given cell array of function handles in one image.
%% 
%% INPUT:
%%      u_cells = the functions in a cell array of function handles
%%      x = the x values to use for plotting
%% OUTPUT:
%%      none, plots an image

function PlotSet(u_cells,x,visual_type)
    n = length(u_cells);
    if visual_type == 'no'
        for k=1:n
            plot(x,arrayfun(u_cells{k},x));
            hold on
        end
    else
        for k=1:n
            plot(x,arrayfun(u_cells{k},x),visual_type);
            hold on
        end
    end
end    
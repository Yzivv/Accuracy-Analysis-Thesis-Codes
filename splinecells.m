%% Creates spline structures from cell functions

function [u_splines, du_splines] = splinecells(u_cells,du_cells,points)
    
    n = length(u_cells);
    u_splines = cell(n,1);
    du_splines = cell(n,1);
    
    x = linspace(0,1,points);
    
    for k = 1:n
        y1 = arrayfun(u_cells{k},x);
        y2 = arrayfun(du_cells{k},x);
        u_splines{k,1} = spline(x,y1);
        du_splines{k,1} = spline(x,y2);
    end
end
        
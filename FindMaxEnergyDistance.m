%% Finds the largest distance between two different functions in a set of 
%% function handles. The distance is with respect to the energy norm
%% ||u-v|| = sqrt(int(a|du-dv|^2+b|u-v|^2))
%%
%% INPUT:
%%      u_cells, du_cells = the function handles and derivative handles
%%      x = the linspace used for numerical integration
%%      a_mean = the function handle for mean alpha used for energy norm
%%      b_mean = the function handle for mean beta
%% OUTPUT:
%%      I = the maximum distance (the "size" of solution cloud)
%%      I_mat = all the distances in a matrix

function [I, I_mat] = FindMaxEnergyDistance(x,u_cells,du_cells,a_mean,b_mean)
    n = length(u_cells);
    I_mat = zeros(n,n);
    I = 0;
    for k = n:-1:1
        for h = 1:k
            if h ~= k
                I_mat(h,k) = energyAB2(x,u_cells{k},du_cells{k},u_cells{h},du_cells{h},a_mean,b_mean);
            end
        end
    end
    I = max(max(I_mat));
end
           
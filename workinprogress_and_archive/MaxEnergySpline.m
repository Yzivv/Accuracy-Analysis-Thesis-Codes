%% Finds the largest distance between two different functions in a set of 
%% function handles. The distance is with respect to the energy norm
%% ||u-v|| = sqrt(int(|u-v|^2 + |du-dv|^2))
%%
%% INPUT:
%%      u_splines = spline structs of the functions
%%      du_splines = spline structs of the derivative functions
%%      x = the linspace used for numerical integration
%% OUTPUT:
%%      I = the maximum distance (the "size" of solution cloud)
%%      I_mat = all the distances in a matrix

function [I, I_mat] = MaxEnergySpline(breaks,u_splines,du_splines)
    n = length(u_splines);
    I_mat = zeros(n,n);
    for k = n:-1:1
        for h = 1:k
            if h ~= k
                I_mat(h,k) = energySpline(breaks,u_splines{k},du_splines{k},u_splines{h},du_splines{h});
            end
        end
    end
    I = max(max(I_mat));
end
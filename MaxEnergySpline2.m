%% Finds the largest distance between two different functions in a set of 
%% function handles. The distance is with respect to the energy norm
%% ||u-v|| = sqrt(int(|u-v|^2 + |du-dv|^2))
%%
%% INPUT:
%%      
%%      u_splines = spline structs of the functions
%%      du_splines = spline structs of the derivative functions
%%      a_mean = array of the mean values of a in each subinterval of breaks
%%      b_mean = array of the mean values of b in each subinterval of breaks
%% OUTPUT:
%%      I = the maximum distance (the "size" of solution cloud)
%%      I_mat = all the distances in a matrix

function [I, I_mat] = MaxEnergySpline2(breaks,u_splines,du_splines,a_mean,b_mean)
    n = length(u_splines);
    I_mat = zeros(n,n);
    for k = n:-1:1
        for h = 1:k
            if h ~= k
                I_mat(h,k) = energySpline2(breaks,u_splines{k},du_splines{k},u_splines{h},du_splines{h},a_mean,b_mean);
            end
        end
    end
    I = max(max(I_mat));
end
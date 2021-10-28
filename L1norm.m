%% Calculates the L1-norm of a given spline structure
%% INPUT:
%%      u_spline = the spline struct of a function approximation
%% OUTPUT:
%%      The L1-norm of the function

function out = L1norm(u_spline)
    
    breaks = u_spline.breaks;
    
    int = quadgk(@(t)abs(ppval(u_spline,t)),breaks(1),breaks(end),'Waypoints',breaks);
    
    out = int;
end
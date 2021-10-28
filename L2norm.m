%% Calculates the L2-norm of a given spline structure.
%% INPUT:
%%      u_spline = the spline struct of a function
%% OUTPUT:
%%      The L2-norm of the function u

function out = L2norm(u_spline)
    
    breaks = u_spline.breaks;
    n = length(breaks)-1;
    
    ucnew = zeros(n,7);
    coefs = u_spline.coefs;
    
    for i=1:n
        ucnew(i,:) = conv(coefs(i,:),coefs(i,:));
    end
    
    splint = mkpp(breaks,ucnew);
    int = quadgk(@(t)ppval(splint,t),breaks(1),breaks(end),'Waypoints',breaks);
    
    out = sqrt(int);
end
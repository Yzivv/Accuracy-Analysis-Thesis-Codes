%% Calculates energy norm of a single spline function with given a and b
%% INPUT:
%%      u_spline = spline struct approximation of some function
%%      du_spline = spline struct approximation of the derivative
%%      a = the function a values in each subinterval of breaks
%%      b = the function b values in each subinterval of breaks
%% OUTPUT:
%%      I = energy norm of u

function I = energySplineSingle(breaks,u_spline,du_spline,a,b)
    
    n = length(breaks)-1;
    ucoefs = u_spline.coefs;
    ducoefs = du_spline.coefs;
    
    ucnew = zeros(n,7);
    ducnew = zeros(n,7);

    for i = 1:n
        ucnew(i,:) = conv(ucoefs(i,:),ucoefs(i,:));
        ducnew(i,:) = conv(ducoefs(i,:),ducoefs(i,:));
    end
    
    am = repmat(a,1,7);
    bm = repmat(b,1,7);
    
    splintcoefs = ucnew.*bm + ducnew.*am;
    %splintcoefs = ucoefs.*bm + ducoefs.*am;
    splint = mkpp(breaks,splintcoefs);
    
    int3 = quadgk(@(t)ppval(splint,t),breaks(1),breaks(end),'Waypoints',breaks);
    
    I = sqrt(int3);
end
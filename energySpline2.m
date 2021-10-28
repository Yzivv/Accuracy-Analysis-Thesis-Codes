%% Evaluating energynorm with splines.
%% This is much faster then the function energyAB.m
%% Calculates the energy norm between two functions u and v
%% |||u - v||| = sqrt(int(a(u'-v')^2+b(u-v)^2dx))
%% the functions used are in my case solutions to the ODE
%% au'' - bu = f.
%% ------
%% INPUT
%%      breaks = linspace of the subintervals of the splines
%%      u_spline = spline approximation of the function u
%%      du_spline = spline approximation of the function du
%%      v_spline = spline approximation of the function v
%%      dv_spline = spline approximation of the function dv
%%      a_mean = array of the mean values of a in each subinterval of breaks
%%      b_mean = array of the mean values of b in each subinterval of breaks
%% OUTPUT
%%      I = energy norm between u and v
function I = energySpline2(breaks,u_spline,du_spline,v_spline,dv_spline,a_mean,b_mean)
    
    n = length(breaks)-1;
    
    ucoefs = u_spline.coefs - v_spline.coefs;
    ducoefs = du_spline.coefs - dv_spline.coefs;
    
    ucnew = zeros(n,7);
    ducnew = zeros(n,7);
    
    for i = 1:n
        ucnew(i,:) = conv(ucoefs(i,:),ucoefs(i,:));
        ducnew(i,:) = conv(ducoefs(i,:),ducoefs(i,:));
    end
    
    am = repmat(a_mean,1,7);
    bm = repmat(b_mean,1,7);
    
    splintcoefs = ucnew.*bm + ducnew.*am;
    %splintcoefs = ucoefs.*bm + ducoefs.*am;
    splint = mkpp(breaks,splintcoefs);
    
    int3 = quadgk(@(t)ppval(splint,t),breaks(1),breaks(end),'Waypoints',breaks);
    
    I = sqrt(int3);
end
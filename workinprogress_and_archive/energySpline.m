%% Evaluating energynorm with splines.
%% This is much faster then the function energyAB.m
%% Calculates the energy norm between two functions u and v
%% |||u - v||| = sqrt(int(a(u'-v')^2+b(u-v)^2dx))
%% the functions used are generally solutions to the ODE
%% au'' - bu = f.
%% ------
%% INPUT
%%      breaks = linspace of the subintervals of the splines
%%      u_spline = spline approximation of the function u
%%      du_spline = spline approximation of the function du
%%      v_spline = spline approximation of the function v
%%      dv_spline = spline approximation of the function dv
%% OUTPUT
%%      I = energy norm between u and v
function I = energySpline(breaks,u_spline,du_spline,v_spline,dv_spline)
    
    n = length(breaks)-1;
    
    ucoefs = u_spline.coefs - v_spline.coefs;
    ducoefs = du_spline.coefs - dv_spline.coefs;

    ucnew = zeros(n,7);
    ducnew = zeros(n,7);

    for i = 1:n
        ucnew(i,:) = conv(ucoefs(i,:),ucoefs(i,:));
        ducnew(i,:) = conv(ducoefs(i,:),ducoefs(i,:));
    end
    
    usplint = mkpp(breaks,ucnew);
    dusplint = mkpp(breaks,ducnew);
        
    int1 = quadgk(@(t)ppval(usplint,t),breaks(1),breaks(end),'Waypoints',breaks);
    int2 = quadgk(@(t)ppval(dusplint,t),breaks(1),breaks(end),'Waypoints',breaks);

    I = sqrt(int1+int2);
end
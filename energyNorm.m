%% Calculates the energy norm related to a,b between two functions u and v
%% |||u - v||| = sqrt(int(a(u'-v')^2+b(u-v)^2dx))
%% the functions used are generally solutions to the ODE
%% au'' - bu = f.
%%
%% INPUT:
%%      
%%      u_spline : spline struct of function u
%%      du_spline : spline struct of du
%%      v_spline : spline struct of v
%%      dv_spline : spline struct of dv
%%      a_mean : function handle
%%      b_mean : function handle
%%      domain : e.g. [0,1], domain of the problem

function I = energyNorm(u_spline,du_spline,v_spline,dv_spline,a_mean,b_mean,domain)
    
    %% Combining the splines so the integration is faster
    
    breaks = u_spline.breaks;
    n = length(breaks)-1;
    
    ucoefs = u_spline.coefs - v_spline.coefs;
    ducoefs = du_spline.coefs - dv_spline.coefs;

    ucnew = zeros(n,7);
    ducnew = zeros(n,7);

    for i = 1:n
        ucnew(i,:) = conv(ucoefs(i,:),ucoefs(i,:));
        ducnew(i,:) = conv(ducoefs(i,:),ducoefs(i,:));
    end
    
    uint = mkpp(breaks,ucnew);
    duint = mkpp(breaks,ducnew);
    
    %% Making the integral function
    
    int_func = @(x) a_mean(x).*ppval(duint,x) + b_mean(x).*ppval(uint,x);
    
    I = integral(int_func,domain(1),domain(2));
    
    I = sqrt(I);
    
    
end
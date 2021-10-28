%% Calculates the analytical upper bounds and the analytical lower bound
%% of DIAM(S(D)) of a given differential equation of the form:
%%
%%      au'' - bu = f
%%
%% INPUT:
%%      a_mean = mean function alpha (function handle)
%%      da_mean = mean function derivative alpha' (function handle)
%%      b_mean = mean function beta (function handle)
%%      f_mean = mean function f (function handle)
%%      delta1 = indeterminacy functions (function handles)
%%      delta2 = ---||---
%%      delta3 = ---||---
%%      bdcond = boundary conditions of the system
%%      domain = domain of the system
%% OUTPUT:
%%      [low, B1, B2, B3, B4] = lower bound and upper bounds B1-B4


function [low, B1, B2, B3, B4] = diameter_bounds(a_mean,da_mean,b_mean,f_mean,delta1,delta2,delta3,bdcond,domain)

    mean_sol = solverbvp(a_mean,da_mean,b_mean,f_mean,domain,bdcond);
    u_mean = @(x) deval(mean_sol,x,1);
    du_mean = @(x) deval(mean_sol,x,2);
    
    
    %% Calculating the constant K_low and K_high
    
    c1_func = @(x) delta1(x) ./ (a_mean(x)-delta1(x));
    c2_func = @(x) delta2(x) ./ (b_mean(x)-delta2(x));
    
    c1 = fminbnd(@(x) -c1_func(x),domain(1),domain(2));
    c2 = fminbnd(@(x) -c2_func(x),domain(1),domain(2));
    
    c = max([c1_func(c1),c2_func(c2)]);

    K_high = sqrt(1+c);
    K_low = sqrt(1-c);
    
    %% Calculating lower bound
    
    top = integral(@(x) delta1(x).*abs(du_mean(x)).^2 + delta2(x).*abs(u_mean(x)).^2 + delta3(x).*abs(u_mean(x)), domain(1),domain(2));
    bot = integral(@(x) (a_mean(x)-delta1(x)).*abs(du_mean(x)).^2 + (b_mean(x) - delta2(x)).*abs(u_mean(x)).^2, domain(1),domain(2));
    
    low = K_low*top/sqrt(bot);
    
    
    %% Calculating upper bound B1
    
    amin = @(x) a_mean(x) - delta1(x);
    min_amin = amin(fminbnd(amin,domain(1),domain(2)));
    
    Cf = 1/(pi*sqrt(min_amin));
    
    t1 = sqrt(integral(@(x) ((delta1(x).*du_mean(x)).^2)./(a_mean(x)-delta1(x)),domain(1),domain(2)));
    t2 = Cf*sqrt(integral(@(x) (delta2(x).*abs(u_mean(x))+delta3(x)).^2, domain(1),domain(2)));
    B1 = 2*K_high*(t1+t2);
    
    
    %% Calculating upper bound B2
    
    t1 = integral(@(x) ((delta1(x).*du_mean(x)).^2)./(a_mean(x)-delta1(x)) + ((delta3(x)+delta2(x).*abs(u_mean(x))).^2)./(b_mean(x)-delta2(x)),domain(1),domain(2));
    
    B2 = 2*K_high*sqrt(t1);
    
    %% Calculating upper bound B3
    
    amin = @(x) a_mean(x) - delta1(x);
    min_amin = amin(fminbnd(amin,domain(1),domain(2)));
    
    Cmax = 1/(pi*sqrt(min_amin));
    
    f_2norm = integral(@(x) (abs(f_mean(x))+delta3(x)).^2,domain(1),domain(2));
    f_2norm = sqrt(f_2norm);
    
    delta3_2norm = integral(@(x) ((delta3(x).^2)), domain(1), domain(2));
    delta3_2norm = sqrt(delta3_2norm);
    
    H_func = @(x) delta1(x)./sqrt(a_mean(x).*(a_mean(x)-delta1(x)));
    H = H_func(fminbnd(H_func, domain(1), domain(2)));
    
    delta2_max = delta2(fminbnd(delta2,domain(1),domain(2)));
    
    B3 = 2*Cmax*f_2norm*(H + delta2_max*Cmax^2 + delta3_2norm);
    
    %% Calculating upper bound B4
    
    amin = @(x) a_mean(x) - delta1(x);
    min_amin = amin(fminbnd(amin,domain(1),domain(2)));
    
    Cmax = 1/(pi*sqrt(min_amin));
    
    f_2norm = integral(@(x) (abs(f_mean(x))+delta3(x)).^2,domain(1),domain(2));
    f_2norm = sqrt(f_2norm);
    
    delta3_2norm = integral(@(x) ((delta3(x).^2)./b_mean(x)), domain(1), domain(2));
    delta3_2norm = sqrt(delta3_2norm);
    
    H1_func = @(x) delta1(x)./sqrt(a_mean(x).*(a_mean(x)-delta1(x)));
    H1 = H1_func(fminbnd(H1_func,domain(1),domain(2)));
    
    H2_func = @(x) delta2(x)./sqrt(b_mean(x));
    H2 = H2_func(fminbnd(H2_func,domain(1),domain(2)));
    
    
    B4 = 2*Cmax*f_2norm*(H1+H2*Cmax) + 2*delta3_2norm;
    
end
     



    
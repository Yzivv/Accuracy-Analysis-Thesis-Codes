%% Solves a boundary value problem of the form
%% au'' - bu = f
%% with given coefficient function handles a,b,f,da.
%% Uses the solver bvp4c

function sol = solverbvp(a,da,b,f,domain,bdcond)
    
    %% Boundary condition
    function res = bc(ya,yb)
        res = [ya(1)-bdcond(1)
               yb(1)-bdcond(2)];
    end
    
    function res = ode(x,y)
        res = [y(2)
               (f(x)+b(x)*y(1)-da(x))/a(x)];
    end

    xmesh = linspace(domain(1),domain(end));
    solinit = bvpinit(xmesh, [1; 1]);
    
    sol = bvp4c(@ode, @bc, solinit);

end
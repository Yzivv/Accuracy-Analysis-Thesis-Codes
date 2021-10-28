%% Calculates the energy norm related to a,b between two functions u and v
%% |||u - v||| = sqrt(int(a(u'-v')^2+b(u-v)^2dx))
%% the functions used are generally solutions to the ODE
%% au'' - bu = f.

function I = energyAB2(x,u,du,v,dv,a,b)
    function out = func(x)
        out = a(x)*(du(x)-dv(x))^2 + b(x)*(u(x)-v(x))^2;
    end
    Y = arrayfun(@func,x);
    I = sqrt(trapz(x,Y));
end
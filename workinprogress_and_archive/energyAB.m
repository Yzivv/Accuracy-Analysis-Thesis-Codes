%% Calculates the Sobolev L^2 norm between two functions u and v
%% |||u - v||| = sqrt(int((u'-v')^2+(u-v)^2dx))
%% the functions used are generally solutions to the ODE
%% au'' - bu = f.

function I = energyAB(x,u,du,v,dv)
    function out = func(x)
        out = (u(x)-v(x))^2 + (du(x)-dv(x))^2;
    end
    Y = arrayfun(@func,x);
    I = sqrt(trapz(x,Y));
end
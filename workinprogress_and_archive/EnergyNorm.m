%% Calculates the energy norm associated with
%% a given solution u and coefficient function a
%% square root of Integral a|u'|^2

function value = EnergyNorm(x, u, a)

 du = derivative(x,u);
 y = du.^2;
 y = a.*y;
 I = trapz(x,y);
 value = sqrt(I);

end

%% Creates the function handle for a piecewise defined polynomial with
%% coefficients

function out = Polydefiner(c1,c2,a,f)
    function g = polynomial(x)
        g = c1+c2*x+x^2*f/(2*a);
    end
    out = @polynomial;
end
%% Looks at the strip of possible coefficients and brings the max and min values of
%% each coefficient at the given mesh of points in an array.

function vals = FindValsConst(a,b,f,x,looking_points)
    n = length(looking_points);
    vals = zeros(6,n);
    for k=1:n
        index = ceil((length(x)-1)*interp1(x,x,looking_points(k)+realmin,'next'));
        vals(1,k) = a(index,1);
        vals(2,k) = a(index,2);
        vals(3,k) = b(index,1);
        vals(4,k) = b(index,2);
        vals(5,k) = f(index,1);
        vals(6,k) = f(index,2);
    end
end
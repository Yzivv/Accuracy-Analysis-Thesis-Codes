%% Creates the input vector from the given set of admissible data D
%%
%% INPUT:
%%      a_mean : Function handles of the mean functions
%%      b_mean
%%      f_mean
%%      delta1 : Function handles of the indeterminacy values
%%      delta2
%%      delta3
%%      domain : problem domain [a,b]
%%      point_amount : how many looking points we use

function input_vector = make_network_input(a_mean,b_mean,f_mean,delta1,delta2,delta3,domain,point_amount)
    
    h = linspace(domain(1),domain(2),2*point_amount + 1);
    looking_points = h(2:2:end);
    
    a_max = @(x) a_mean(x) + delta1(x);
    a_min = @(x) a_mean(x) - delta1(x);
    b_max = @(x) b_mean(x) + delta2(x);
    b_min = @(x) b_mean(x) - delta2(x);
    f_max = @(x) f_mean(x) + delta3(x);
    f_min = @(x) f_mean(x) - delta3(x);
    
    vals = zeros(6,point_amount);
    
    vals(1,:) = a_min(looking_points);
    vals(2,:) = a_max(looking_points);
    
    vals(3,:) = b_min(looking_points);
    vals(4,:) = b_max(looking_points);
    
    vals(5,:) = f_min(looking_points);
    vals(6,:) = f_max(looking_points);
    
    input_vector = transpose(reshape(vals,1,[]));

end
    
    
   
    
%% Uses a given network to inference on the given set of admissible data D
%%
%% INPUT:
%%      network = network struct
%%      a_mean = mean function handles
%%      b_mean = --||--
%%      f_mean = --||--
%%      delta1 = indeterminacy value function handles
%%      delta2 = --||--
%%      delta3 = --||--
%%      domain = [a,b] domain of our problem
%% OUTPUT:
%%      network output which should approximate Diam(S(D))

function diam = inference(network,a_mean,b_mean,f_mean,delta1,delta2,delta3,domain)
    
    input_size = network.inputs{1}.size;
    
    looking_point_amount = input_size/6;
    
    vals = zeros(6,looking_point_amount);
    diam = 1;
    
end
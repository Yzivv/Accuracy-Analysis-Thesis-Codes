%% Testing how well the conference network deals with more general inputs
%% Now using piecewise constant indeterminacy and spline mean funcs.

test_points = 600;
bdcond = [0,0];
domain = [0,1];
arange = [1.0,3.0];
brange = [1.0,3.0];
frange = [3.0,10.0];
max_delta_1 = 0.25;
max_delta_2 = 0.25;
max_delta_3 = 0.25;

oscillations = 15;

network = load('Conference network.mat');
network = network.network1;
input_size = network.inputs{1}.size;
looking_point_amount = input_size/6;


up_bounds = zeros(2,test_points);
low_bounds = zeros(1,test_points);
network_outputs = zeros(1,test_points);

for k = 1 : test_points
    
    %% Rolling random third degree polynomials
    
    [a_mean, delta1, da_mean] = randomadmissibledata(oscillations,arange,domain,max_delta_1,33);
    [b_mean, delta2, ~] = randomadmissibledata(oscillations,brange,domain,max_delta_1,16);
    [f_mean, delta3, ~] = randomadmissibledata(oscillations,frange,domain,max_delta_1,16);
    
    
    %% Making the network input
    
    network_input = make_network_input(a_mean,b_mean,f_mean,delta1,delta2,delta3,domain,looking_point_amount);
    
    %% Finding bounds and output
    
    [low, up1, up2] = diameter_bounds(a_mean,da_mean,b_mean,f_mean,delta1,delta2,delta3,bdcond,domain);
    
    network_output = network(network_input);
    
    up_bounds(:,k) = [up1;up2];
    
    low_bounds(1,k) = low;
    
    network_outputs(1,k) = network_output;
    
    k
end

dd = [low_bounds; up_bounds; network_outputs];
d2 = sortrows(transpose(dd),4);

plot(d2(:,4),'ro');
hold on
plot(d2(:,1),'b');
plot(d2(:,2),'g');



    
    
    
    
    
    
    
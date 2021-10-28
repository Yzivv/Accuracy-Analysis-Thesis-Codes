%% Testing the network models on different types of data.
%% We set the mean coefficient as a spline polynomial.
%% The indeterminacy parameters are set as either spline polynomials or sine functions.
%% First test with only 3 oscillation points in the domain and the second with 6.

%% All tests are done within the constraints of the training data of model 1.

%% Test 1: 3 spline points for mean function, 3 spline points for indeterminacy function
N = 150;
test1_results = zeros(8,N);
bdcond = [0,0];
domain = [0,1];
NN1 = load('Conference network.mat');
NN2 = load('model_2.mat');

model_1 = NN1.network1;
model_2 = NN2.network11;

model_1_points = 4;
model_2_points = 10;

for k=1:N
    tic;
    
    [a_mean, delta1, da_mean] = randomspline(3,[1,3],[0,1],[0.05,0.3],3);
    [b_mean, delta2, db_mean] = randomspline(3,[1,3],[0,1],[0.05,0.3],3);
    [f_mean, delta3, df_mean] = randomspline(3,[3,10],[0,1],[0.05,0.3],3);
    
    model_1_input = make_network_input(a_mean,b_mean,f_mean,delta1,delta2,delta3,domain,model_1_points);
    model_2_input = make_network_input(a_mean,b_mean,f_mean,delta1,delta2,delta3,domain,model_2_points);
    
    [low, B1, B2, B3, B4] = diameter_bounds(a_mean,da_mean,b_mean,f_mean,delta1,delta2,delta3,bdcond,domain);
    approx = adaptbruteforce(a_mean,b_mean,f_mean,delta1,delta2,delta3,domain,bdcond,60,20);
    model_1_output = model_1(model_1_input);
    model_2_output = model_2(model_2_input);
    
    test1_results(1,k) = approx;
    test1_results(2:6,k) = [low, B1, B2, B3, B4];
    test1_results(7,k) = model_1_output;
    test1_results(8,k) = model_2_output;
    toc;
    k
end
'Test 1 done'
save('nn_splinetest_1_results','test1_results')

%% Test 2: 6 spline points for mean and indeterminacy

N = 250;
test2_results = zeros(8,N);

for k=1:N
    tic;
    
    [a_mean, delta1, da_mean] = randomspline(6,[1,3],[0,1],[0.05,0.3],6);
    [b_mean, delta2, db_mean] = randomspline(6,[1,3],[0,1],[0.05,0.3],6);
    [f_mean, delta3, df_mean] = randomspline(6,[3,10],[0,1],[0.05,0.3],6);
    
    model_1_input = make_network_input(a_mean,b_mean,f_mean,delta1,delta2,delta3,domain,model_1_points);
    model_2_input = make_network_input(a_mean,b_mean,f_mean,delta1,delta2,delta3,domain,model_2_points);
    
    [low, B1, B2, B3, B4] = diameter_bounds(a_mean,da_mean,b_mean,f_mean,delta1,delta2,delta3,bdcond,domain);
    approx = adaptbruteforce(a_mean,b_mean,f_mean,delta1,delta2,delta3,domain,bdcond,60,20);
    model_1_output = model_1(model_1_input);
    model_2_output = model_2(model_2_input);
    
    test2_results(1,k) = approx;
    test2_results(2:6,k) = [low, B1, B2, B3, B4];
    test2_results(7,k) = model_1_output;
    test2_results(8,k) = model_2_output;
    toc;
    k
end
'Test 2 done'
save('nn_splinetest_2_results','test2_results')
%% Test 3: 10 spline points for mean and indeterminacy

% test3_results = zeros(8,N);
% 
% for k=1:N
%     tic;
%     
%     [a_mean, delta1, da_mean] = randomspline(10,[1,3],[0,1],[0.05,0.3],10);
%     [b_mean, delta2, db_mean] = randomspline(10,[1,3],[0,1],[0.05,0.3],10);
%     [f_mean, delta3, df_mean] = randomspline(10,[3,10],[0,1],[0.05,0.3],10);
%     
%     model_1_input = make_network_input(a_mean,b_mean,f_mean,delta1,delta2,delta3,domain,model_1_points);
%     model_2_input = make_network_input(a_mean,b_mean,f_mean,delta1,delta2,delta3,domain,model_2_points);
%     
%     [low, B1, B2, B3, B4] = diameter_bounds(a_mean,da_mean,b_mean,f_mean,delta1,delta2,delta3,bdcond,domain);
%     approx = adaptbruteforce(a_mean,b_mean,f_mean,delta1,delta2,delta3,domain,bdcond,60,20);
%     model_1_output = model_1(model_1_input);
%     model_2_output = model_2(model_2_input);
%     
%     test3_results(1,k) = approx;
%     test3_results(2:6,k) = [low, B1, B2, B3, B4];
%     test3_results(7,k) = model_1_output;
%     test3_results(8,k) = model_2_output;
%     toc;
%     k
% end
% 'Test 3 done'

% %% Test 4: high oscillations with sine functions
% 
% for k=1:N
%     [low, B1, B2, B3, B4] = diameter_bounds(a_mean,da_mean,b_mean,f_mean,delta1,delta2,delta3,bdcond,domain);
%     model_1_output = inference(network1,a_mean,b_mean,f_mean,delta1,delta2,delta3,domain);
%     model_2_output = inference(network2,a_mean,b_mean,f_mean,delta1,delta2,delta3,domain);
% end
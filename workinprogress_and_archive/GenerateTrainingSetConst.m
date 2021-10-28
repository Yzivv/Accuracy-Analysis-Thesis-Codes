%% Generates a training dataset with given constraints to the dataset D.
%% ------
%% INPUT
%% ------
%% arang = [a11,a12; ... ; an1,an2] lower and upper bounds for mean alpha in each subinterval
%% brang = ---||---
%% frang = ---||---
%% deltamax = maximum value of indeterminacy parameter delta
%% gammamax = ---||---
%% epsilmax = ---||---
%% x = [x0,x1,...,xn] subintervals of the data D
%% looking_points = given points used as network input 
%% setsize = amount of examples made
%% func_amount = size of the subset of the solution cloud of each example
%% bdcond = boundary condition of ODE
%% sol_intervals = amount of subintervals in each subinterval of the data used for generating solution cloud elements
function dataset = GenerateTrainingSetConst(arang,brang,frang,deltamax,gammamax,epsilmax,x,looking_points,setsize,func_amount,bdcond)
    
    dataset = cell(2,1);
    output = zeros(1,setsize);
    input = zeros(length(looking_points)*6,setsize);
    n = length(arang);
    
    for k=1:setsize
        tic;
        %% Picking a random value of indeterminacies in each subinterval
        delta = rand(n,1).*deltamax;
        gamma = rand(n,1).*gammamax;
        epsil = rand(n,1).*epsilmax;
        
        %% Picking random mean coefficients from the given ranges
        a_mean = arang(:,1) + rand(n,1).*(arang(:,2)-arang(:,1));
        b_mean = brang(:,1) + rand(n,1).*(brang(:,2)-brang(:,1));
        f_mean = frang(:,1) + rand(n,1).*(frang(:,2)-frang(:,1));
        
        %% Generate one training example
        [I,~,~,value] = TrainExample(a_mean,b_mean,f_mean,delta,gamma,epsil,x,looking_points,func_amount,bdcond);
        value = reshape(value,1,[]);
        input(:,k) = value;
        output(1,k) = I;
        
        %% Save the dataset to a file
        dataset{1,1} = input;
        dataset{2,1} = output;
        save('firstdataset.mat','dataset')
        k
        toc;
    end
end

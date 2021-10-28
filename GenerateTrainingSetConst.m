%% Generates a training dataset with given constraints to the possible input datasets D.
%% ------
%% INPUT
%% ------
%% arang = [a11,a12] lower and upper bounds for mean alpha 
%% brang = ---||---
%% frang = ---||---
%% deltamax = maximum value of indeterminacy parameter delta
%% gammamax = ---||---
%% epsilmax = ---||---
%% x = [x0,x1,...,xn] subintervals of the data D
%% looking_points = given points used as network input 
%% sol_intervals = the amount of splits we do inside each subinterval for possible solutions
%% setsize = amount of examples made
%% func_amount = size of the subset of the solution cloud of each example
%% bdcond = boundary condition of ODE
%% filename = the name of the datafile we save into
function dataset = GenerateTrainingSetConst(arang,brang,frang,deltamax,gammamax,epsilmax,x,looking_points,sol_intervals,setsize,func_amount,bdcond,filename)
    
    %% Half of the set is made with fully random values in the indeterminacy ranges.
    %% The other half is given constraints of either having small or high indeterminacies.
    
    setsize = setsize + (4 - rem(setsize,4)); %% Make the set divisible by 4 so we make 4 different parts
    dataset = cell(5,1);
    output = zeros(1,setsize);
    up_bounds = zeros(1,setsize);
    up_bounds2 = zeros(1,setsize);
    low_bounds = zeros(1,setsize);
    input = zeros(length(looking_points)*6,setsize);
    n = length(x)-1;
    halfpoint = setsize/2;
    
    
    %% The first half of the set is fully random values of all indeterminacy parameters
    for k=1:halfpoint
        tic;
        
        %% Picking random mean coefficients from the given ranges
        a_mean = arang(:,1) + rand(n,1).*(arang(:,2)-arang(:,1));
        b_mean = brang(:,1) + rand(n,1).*(brang(:,2)-brang(:,1));
        f_mean = frang(:,1) + rand(n,1).*(frang(:,2)-frang(:,1));
        
        %% Picking a random value of indeterminacies in each subinterval
        delta = a_mean.*rand(n,1).*deltamax;
        gamma = b_mean.*rand(n,1).*gammamax;
        epsil = f_mean.*rand(n,1).*epsilmax;
        
        %% Generate one training example
        [I,~,~,value,up,up2,low] = TrainExample2(a_mean,b_mean,f_mean,delta,gamma,epsil,x,looking_points,sol_intervals,func_amount,bdcond);
        value = reshape(value,1,[]);
        input(:,k) = value;
        output(1,k) = I;
        up_bounds(1,k) = up;
        up_bounds2(1,k) = up2;
        low_bounds(1,k) = low;
        
        k
        toc;
    end
    
    %% Now we make one quarter of the dataset with smaller indeterminacies
    %% and another quarter with high indeterminacies.
    start = halfpoint + 1;
    third_quarter = halfpoint+halfpoint/2;
    for k=start:third_quarter
        tic;
        
        %% Picking random mean coefficients from the given ranges
        a_mean = arang(:,1) + rand(n,1).*(arang(:,2)-arang(:,1));
        b_mean = brang(:,1) + rand(n,1).*(brang(:,2)-brang(:,1));
        f_mean = frang(:,1) + rand(n,1).*(frang(:,2)-frang(:,1));
        
        %% Picking a random small value of indeterminacies.
        delta = a_mean.*(0.35.*rand(n,1).*deltamax);
        gamma = b_mean.*(0.35.*rand(n,1).*gammamax);
        epsil = f_mean.*(0.35.*rand(n,1).*epsilmax);
        
        %% Generate one training example
        [I,~,~,value,up,up2,low] = TrainExample2(a_mean,b_mean,f_mean,delta,gamma,epsil,x,looking_points,sol_intervals,func_amount,bdcond);
        value = reshape(value,1,[]);
        input(:,k) = value;
        output(1,k) = I;
        up_bounds(1,k) = up;
        up_bounds2(1,k) = up2;
        low_bounds(1,k) = low;
        
        k
        toc;
    end
    
    %% The high value indeterminacy set is made here
    start = third_quarter + 1;
    for k=start:setsize
        tic;
        
        %% Picking random mean coefficients from the given ranges
        a_mean = arang(:,1) + rand(n,1).*(arang(:,2)-arang(:,1));
        b_mean = brang(:,1) + rand(n,1).*(brang(:,2)-brang(:,1));
        f_mean = frang(:,1) + rand(n,1).*(frang(:,2)-frang(:,1));
        
        %% Picking a random large value of indeterminacies.
        delta = a_mean.*((1-0.25*rand(n,1)).*deltamax);
        gamma = b_mean.*((1-0.25*rand(n,1)).*gammamax);
        epsil = f_mean.*((1-0.25*rand(n,1)).*epsilmax);
        
        %% Generate one training example
        [I,~,~,value,up,up2,low] = TrainExample2(a_mean,b_mean,f_mean,delta,gamma,epsil,x,looking_points,sol_intervals,func_amount,bdcond);
        value = reshape(value,1,[]);
        input(:,k) = value;
        output(1,k) = I;
        up_bounds(1,k) = up;
        up_bounds2(1,k) = up2;
        low_bounds(1,k) = low;
        
        k
        toc;
    end
    
    
    
    %% Save the dataset to a file
    dataset{1,1} = input;
    dataset{2,1} = output;
    dataset{3,1} = low_bounds;
    dataset{4,1} = up_bounds;
    dataset{5,1} = up_bounds2;
    
    save(filename,'dataset')
end


    
    
    
    
    
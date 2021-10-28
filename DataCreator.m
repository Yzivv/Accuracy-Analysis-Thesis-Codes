%% DataSetCreation function

%% setting the constraints on the datasets D
function out = DataCreator(setsize, func_amount, filename)
    arang = [1,5];
    brang = [1,5];
    frang = [1,10];
    
    %% How many percent the distance from the mean function is allowed to be
    %% e.g. if f_mean = 10 and maxepsil = 0.3 -> f data is in [7,13]
    maxdelta = 0.3;
    maxgamma = 0.3;
    maxepsil = 0.3;

    bdcond = [0,0];

    data_subintervals = 10; %has to be a number that divides 100
    sol_subintervals = 4;

    %% Setting the amount of points we look at the strips in and size of dataset
    x = linspace(0,1,data_subintervals+1);
    h = (x(2)-x(1))/2;
    looking_space = h:2*h:1;

    dataset = GenerateTrainingSetConst(arang,brang,frang,maxdelta,maxgamma,maxepsil,x,looking_space,sol_subintervals,setsize,func_amount,bdcond,filename);
    out = 1;
end
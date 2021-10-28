%% DataSetCreation script

%% setting the constraints on the datasets D
arang = [1,3;1,3;1,3;1,3];
brang = [1,3;1,3;1,3;1,3];
frang = [1,3;1,3;1,3;1,3];
maxdelta = 0.2;
maxgamma = 0.2;
maxepsil = 0.2;

bdcond = [0,0];

%% Setting the amount of points we look at the strips in and size of dataset
x = linspace(0,1,length(arang)+1);
h = (x(2)-x(1))/2;
looking_space = 0.125:0.25:1;
setsize = 1;

%% How many functions are used to approximate the solution cloud in each example
func_amount = 300;

dataset = GenerateTrainingSetConst(arang,brang,frang,maxdelta,maxgamma,maxepsil,x,looking_space,setsize,func_amount,bdcond);
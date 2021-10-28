%% Combines data cell arrays into an input matrix and output matrix.
%% output matrix also contains the lower and upper bounds

function [input, output] = combinedata(dataset)
    
    s = size(dataset);
    sets = s(2);
    output_rows = s(1);
    
    h = size(dataset{1,1});
    input_rows = h(1);
    
    datapoints = 0;
    
    for j=1:sets
        datapoints = datapoints + length(dataset{1,j});
    end 
       
    input_mat = [];
    output_mat = [];
    
    for k=1:sets
        input_mat = [input_mat, dataset{1,k}];
        output_new = [];
        for h=2:output_rows
            output_new = [output_new; dataset{h,k}];
        end
        output_mat = [output_mat, output_new] ;
    end
    
    input = input_mat;
    output = output_mat;
end
    
    
%% Combines dataset structures into one and saves with given name
%% 
%% INPUT:
%%      datasets = [dataset1, dataset2, ...]
%%                  these datasets are a 1x1 struct with a field 'dataset'
%%      name = string name to what the new one is saved to
%% OUTPUT:
%%      dataset = the combined dataset structure

function dataset = combine_structs(datasets, name)
    
    dataset = cell(5,1);
    
    sizes = size(datasets);
    dataset_amount = sizes(2);
    
    for k = 1:dataset_amount
        dataset{1} = [dataset{1}, datasets(k).dataset{1}];
        dataset{2} = [dataset{2}, datasets(k).dataset{2}];
        dataset{3} = [dataset{3}, datasets(k).dataset{3}];
        dataset{4} = [dataset{4}, datasets(k).dataset{4}];
        dataset{5} = [dataset{5}, datasets(k).dataset{5}];
    end
    
    save(name,'dataset')
end
    
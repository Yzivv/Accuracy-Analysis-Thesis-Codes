function data = datacell_to_matrix(dataset)
    
    data(:,1) = dataset{2};
    data(:,2) = dataset{5};
    data(:,3) = dataset{4};
    data = sortrows(data);
end
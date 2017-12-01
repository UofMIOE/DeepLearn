function [new, index, transform] = dataTransform(data)

    len = length(data);
    count = sum(data);

    fprintf('\nNumber of ones in the time series %d.\n', count);

    num = len - 1;

    i = 2;
    factors_list = [];
    while i < (num ^ .5) + 1
        if mod(num,i) == 0
            factors_list = [factors_list, i, (num / i)];
        end
        i  = i + 1;
        factors_list = sort(factors_list);
    end
    factors_list;
    index = [];
    new = [];

    if data(len) == 0
        factors_list = 2:1:10;
    end
    




    for f = 1:length(factors_list)
        step = factors_list(f);
        indexer = 1:step:len;
        index = indexer;
        new = data(indexer);
        if sum(new) == count
            fprintf('Data Transformed with a step of %d.\n', step);
            fprintf('Removed %d zeros from the data. \n', len - length(new));
            transform = 1;
            return
        elseif f == length(factors_list)
            
            new = [];
            index = [];
            fprintf('No possible transformation found \n');
            transform = 0;
            return
        else
            continue
        end

    end
    
    fprintf('No possible transformation found \n');
    transform = 0;
end
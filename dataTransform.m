function [new, index] = dataTransform(data)
    
    len = length(data);
    count = sum(data);
    
    
        
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
       index = 1:2:len;
       new = data(index);
       fprintf('\nData Transformed with a step of %d.\n', 2);
       fprintf('Removed %d zeros from the data. \n', len - length(new));
       return
       
    end
    
    for f = 1:length(factors_list)
        step = factors_list(f);
        indexer = 1:step:len;
        index = indexer;
        new = data(indexer);
        if sum(new) == count
            fprintf('\nData Transformed with a step of %d.\n', step);
            fprintf('Removed %d zeros from the data. \n', len - length(new));
            return
        elseif f == length(factors_list)
            new = [];
            index = [];
            fprintf('No possible transformation found \n');
            return
        else
            continue
        end
       
    end
    fprintf('No possible transformation found');
end

function [new] = dataTransform(data)
    
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
    
    new = [];
    for f = 1:length(factors_list)

        new = removeElements(data, factors_list(f) - 1);
        if sum(new) == count
            fprintf('\nData Transformed with a step of %d.\n', factors_list(f) -1);
            fprintf('Removed %d zeros from the data. \n', len - length(new));
            return
        elseif f == length(factors_list)
            new = [];
            fprintf('No possible transformation found');
            return
        else
            continue
        end
       
    end
end


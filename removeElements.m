function [new] = removeElements(data, step)
    
    i = step;
    new = [];
    for k = 1:length(data)
        if i == step
            ele = data(k);
            new = [new, ele];
            i = i - 1;
        elseif i == 0
            i = step;
            continue
        else
            i = i - 1;
            continue 
        end
    end
    
end

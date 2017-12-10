function [misclass_error, level] = hold_out(testing_set_input, test_prediction, test_results_actual)

x = testing_set_input'
y = test_prediction'
z = categorical(test_results_actual')

%size of test prediction
size_row = size(y,1);
size_column = size(y,2);

%find level for best accuracy
level = fminsearch(y-z)

for 1:size_row
    
    if (y(:,1) < level)
        y(:,1) = 0 
    end
    
    else
        y(:,2) = 0 
    end
    
end


%growth to hold out
p = 1/10;

n = [x y];

c = cvpartition(n,'HoldOut',p) 

error_1 = @(xT,yT,xt,yt)(sum(~strcmp(yt,classify(xt,xT,yT))));

misclass_error = sum(crossval(error_1,meas,y,'partition',c))...
           /sum(c.TestSize)
       
end



%Set input data to 'data_in'


time_series = dataSplit(data_in);

input_matrix = [];
input_targets = [];
results = cell(length(time_series),3);
for i=length(time_series)
    ts_mat = cell2mat(time_series(i));
    
    [input_matrix, input_targets] = baselinePipeline(ts_mat);
    
    [test_Y, test_T, perf] = SRNN(input_matrix, input_targets);
    
    test_Y = cell2mat(test_Y);
    results{i,1} = test_Y;
    results{i,2} = test_T;
    results{i,3} = perf;
end


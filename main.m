
%Set input data to 'data_in'


time_series = dataSplit(data_in);

pipelines = {@baselinePipeline, @pcaPipeline, @miPipeline};

%#######################################################################
%Time Delay Neural Network
%TDNN is run using all 3 pipelines

% 'results' is a cell of cells that contains the results of the testing of
% the neural nets for the baselinePipeline{1}, the pcaPipeline{2}, and the
% miPipeline{3}.
%#######################################################################


input_matrix = [];
input_targets = [];
resultsTDNN = cell(3,1);
for p=1:length(pipelines)
    for i=1:length(time_series)

        ts_mat = cell2mat(time_series(i));

        [input_matrix, input_targets] = pipelines{p}(ts_mat);

        [test_Y, test_T, perf] = TDNN(input_matrix, input_targets);

        test_Y = cell2mat(test_Y);
        resultsTDNN{p}{i,1} = test_Y;
        resultsTDNN{p}{i,2} = test_T;
        resultsTDNN{p}{i,3} = perf;
    end
end

%######################################################################



%#######################################################################
%Simple Recurrent Neural Network
%sRNN is run using all 3 pipelines
%#######################################################################


input_matrix = [];
input_targets = [];
resultsSRNN= cell(3,1);
for p=1:length(pipelines)
    for i=1:length(time_series)

        ts_mat = cell2mat(time_series(i));

        [input_matrix, input_targets] = pipelines{p}(ts_mat);

        [test_Y, test_T, perf] = SRNN(input_matrix, input_targets);

        test_Y = cell2mat(test_Y);
        resultsSRNN{p}{i,1} = test_Y;
        resultsSRNN{p}{i,2} = test_T;
        resultsSRNN{p}{i,3} = perf;
    end
end

%######################################################################


%#######################################################################
%Long Short Term Neural Network
%LSTNN is run using all 3 pipelines
%#######################################################################



input_matrix = [];
input_targets = [];
resultsLSTNN= cell(3,1);
for p=1:length(pipelines)
    for i=1:length(time_series)

        ts_mat = cell2mat(time_series(i));

        [input_matrix, input_targets] = pipelines{p}(ts_mat);

        [test_Y, test_T, perf] = LSTNN(input_matrix, input_targets);

        test_Y = cell2mat(test_Y);
        resultsLSTNN{p}{i,1} = test_Y;
        resultsLSTNN{p}{i,2} = test_T;
        resultsLSTNN{p}{i,3} = perf;
    end
end

%######################################################################

function [test_prediction, test_results_actual, testPerformance] = LSTNN(input_matrix, purchase_output)

%total matrix 
%combined with [input_matrix purchase_output]
total_matrix = [input_matrix purchase_output];
total_matrix_inverted = total_matrix';

%divide up matrix
[input_matrix_final,valInd,testing_matrix] = dividerand(total_matrix_inverted,0.7,0,0.3);

%--------------------------------------------------------------------------
%create training matrix 
input_matrix_final_inv = input_matrix_final';
input_matrix_final_inputs = input_matrix_final_inv;
results_column = size(input_matrix_final_inputs,2);

%inputs for training set
training_set_input = input_matrix_final_inputs;
training_set_input(:,results_column) = [];

%outputs for training set
training_set_output = input_matrix_final_inputs(:,results_column);
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
%create test matrix
testing_matrix_final_inv = testing_matrix';
testing_matrix_final_inputs = testing_matrix_final_inv;
results_column_testing = size(testing_matrix_final_inputs,2);

%inputs for testing set
testing_set_input = testing_matrix_final_inputs;
testing_set_input(:,results_column_testing) = [];

%outputs for training set
testing_set_output = testing_matrix_final_inputs(:,results_column_testing);

%--------------------------------------------------------------------------

inputSize = size(training_set_input,2);
%outputSize = size(training_set_input,2);
outputSize = 2;

outputMode = 'last';
numClasses = 2;

layers = [ ...
    sequenceInputLayer(inputSize)
    lstmLayer(outputSize,'OutputMode',outputMode)
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];


maxEpochs = 150;
miniBatchSize = 27;
shuffle = 'never';

options = trainingOptions('sgdm', ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'Shuffle', shuffle);


%convert training set data for input into the LSTNN
training_set_output_categorical = categorical(training_set_output);
training_set_input_converted = converting(training_set_input);

net = trainNetwork(training_set_input_converted,training_set_output_categorical,layers,options);


%test neural network

%convert testing set data for input into the LSTNN
testing_set_output_categorical = categorical(testing_set_output);
testing_set_input_converted = converting(testing_set_input);

miniBatchSize = 27;
YPred = classify(net,testing_set_input_converted, ...
    'MiniBatchSize',miniBatchSize);

acc = sum(YPred == testing_set_output_categorical)./numel(testing_set_output_categorical);

test_prediction = YPred;
test_results_actual = testing_set_output_categorical;
testPerformance = acc;

end
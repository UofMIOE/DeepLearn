function [test_Y, test_T, perf] = TDNN(input_matrix, purchase_output)

    num_ts = size(input_matrix,1); %total number of timestamps
    num_train = floor(num_ts * .75);  %records for training
    num_test = num_ts - num_train;   %records for testing

    % Partition 
    test_X = transpose(input_matrix(num_train+1:end,:));%input for testing
    test_T = transpose(purchase_output(num_train+1:end)); %targets for testing
    train_X = transpose(input_matrix(1:num_train,:));  %input set for training
    train_T = transpose(purchase_output(1:num_train,:)); %targets for training



    % Constructing NN
    nn = timedelaynet(1:3,12);
    nn = configure(nn,train_X, train_T);

    nn.layers{2}.transferFcn = 'tansig';

    train_X = con2seq(train_X);
    train_T = con2seq(train_T);
    test_X = con2seq(test_X);

    [Xs,Xi,Ai,Ts] = preparets(nn,train_X,train_T);

    % Training on NN
    nn = train(nn,Xs,Ts,Xi,Ai);
    view(nn)

    % Performance Test
    [Y,Xf,Af] = nn(Xs,Xi,Ai);
    

    % Calculate Prediction
    [netc,Xic,Aic] = closeloop(nn,Xf,Af);


    test_Y = netc(test_X,Xic,Aic);
    perf = perform(netc,Ts,Y);
end


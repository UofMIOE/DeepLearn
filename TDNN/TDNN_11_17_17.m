% Time Delay Neural Network Trial
% Only Takes in One Input One Output as of Now

% Construct Time Series Data
time_series_sequence = [ESTIMATED_MILEAGE, PURCHASE_EVENT]

% Partition 
Xnew = ESTIMATED_MILEAGE(15:20);
ESTIMATED_MILEAGE_input = ESTIMATED_MILEAGE(1:14);
PURCHASE_EVENT_input = PURCHASE_EVENT(1:14);

% Constructing NN
nn = timedelaynet(1:2,10)
[Xs,Xi,Ai,Ts] = preparets(nn,ESTIMATED_MILEAGE_input,PURCHASE_EVENT_input)

% Training on NN
nn_training = train(net,Xs,Xi,Ai,Ts);

% Performance Test
[Y,Xf,Af] = net(Xs,Xi,Ai)
perf = perform(net,Ts,Y)

% Calculate Prediction
[netc,Xic,Aic] = closeloop(net,Xf,Af)
view(netc)





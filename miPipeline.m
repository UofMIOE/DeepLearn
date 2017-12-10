function [input_matrix2, purchase_output] = miPipeline(read_in)

%mutual information pipeline

%read_data_in
data_in = read_in;

%define time series
time = data_in(:,2); %date

%set specified time_series
est_mil = data_in(:,3);
ro_event = data_in(:,5);
ro_total = data_in(:,6);
p_total_2_or_more = data_in(:,7);
p_total_asian = data_in(:,8);
p_total_black = data_in(:,9);
p_total_hawaii = data_in(:,10);

%create input matrix
input_matrix2 = [est_mil ro_event ro_total p_total_2_or_more p_total_asian p_total_black p_total_hawaii];

%calculate mutual information
Q = 12; %set Q to 12 (standard value)
[features,weights] = miPipelineFunctions(input_matrix2,time,Q);

%only select the top 4 features
number_records = size(data_in,1);
input_matrix_final = zeros(0,number_records);
for i = 1:4
    x = features(i,1);
    input_matrix_final = [input_matrix_final input_matrix2(:,x)];
end

%set input matrix
input_matrix2 = input_matrix_final;

%set specified output
%output matrix
purchase_output = data_in(:,4);
end

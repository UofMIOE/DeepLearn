%mutual information pipeline 

%read_data_in
data_in = temp_storage;

%define time series
time = data_in(:,10); %date

%set specified time_series
est_mil = data_in(:,12);
ro_event = data_in(:,14);
ro_total = data_in(:,15);
p_total_2_or_more = data_in(:,204);
p_total_asian = data_in(:,205);
p_total_black = data_in(:,206);
p_total_hawaii = data_in(:,207);

%create input matrix
input_matrix = [est_mil ro_event ro_total p_total_2_or_more p_total_asian p_total_black p_total_hawaii];

%calculate mutual information
Q = 12; %set Q to 12 (standard value)
[features,weights] = MI_FS_pipeline_test(input_matrix,time,Q);

%only select the top 4 features 
number_records = size(data_in,1);
input_matrix_final = zeros(0,number_records);
for i = 1:4
    x = features(i,1)
    input_matrix_final = [input_matrix_final input_matrix(:,x)];
end

%set input matrix
input_matrix = input_matrix_final;

%set specified output
%output matrix
purchase_output = data_in(:,13);
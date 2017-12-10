function [input_matrix, purchase_output] = baselinePipeline(read_in)

%baseline pipeline

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
input_matrix = [time est_mil ro_event ro_total p_total_2_or_more p_total_asian p_total_black p_total_hawaii];

%set specified output
%output matrix
purchase_output = data_in(:,4);
end

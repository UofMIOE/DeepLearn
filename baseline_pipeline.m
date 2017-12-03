%baseline pipeline 

data_in = read_in;

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
input_matrix = [time est_mil ro_event ro_total p_total_2_or_more p_total_asian p_total_black p_total_hawaii];

%set specified output
%output matrix
purchase_output = data_in(:,13);
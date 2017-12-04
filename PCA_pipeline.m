%PCA Pipeline

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

%create pca_input
pca_input = [time est_mil ro_event ro_total p_total_2_or_more p_total_asian p_total_black p_total_hawaii];

[coeff,score,latent] = pca(pca_input);

%find significant variables 
latent_transformed = latent';

%store results of significant variables
sig_variables_location = zeros(0,1);

for iterator = 1:8
    if latent_transformed(1,iterator) > 0.1
       sig_variables_location = [sig_variables_location iterator];
    end
end

%reconstructed variables
re = score*coeff';

%set pca pipeline input matrix
%only select significant variables 
size_sig_variables_location = size(sig_variables_location,2);
number_records = size(data_in,1);
input_matrix = zeros(0,number_records);
for iterator_2 = 1:size_sig_variables_location
    x = sig_variables_location(1,iterator_2)
    
    input_matrix = [input_matrix re(:,x)];
    
end

%only selected significant reconstructed variables
input_matrix = input_matrix;

%set specified output
%output matrix
purchase_output = data_in(:,13);

function [input_matrix_converted] = converting(input_matrix)

%dimensions of inported data
input_matrix_rows = size(input_matrix,1);
input_matrix_columns = size(input_matrix,2);

storage_each_time_step = [];
total_storage = [];


for row_iter = 1:input_matrix_rows
   
    for column_iter = 1:input_matrix_columns
        
        storage_each_time_step = [storage_each_time_step input_matrix(row_iter, column_iter)];
               
    end
    
    storage_each_time_step = storage_each_time_step';
    total_storage = [total_storage storage_each_time_step];
    storage_each_time_step = [];
    
end

cell_storage = [];

%convert to cell 
for iter_con = 1:input_matrix_rows
    cell_storage = [cell_storage mat2cell(total_storage(:,iter_con),input_matrix_columns)];
    

end

input_matrix_converted = cell_storage';

end
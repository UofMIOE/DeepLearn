%function to import distinct cust_id and coded_vin

%read in data 
in_data = TrialDataUse;

%find size of the data
n_rows = size(in_data,1);
n_columns = size(in_data,2);

%empty storage matrix
temp_storage = zeros(0,n_columns);

%debugging check
debug = zeros(0,n_columns);

%single record index
single_record_index = zeros(0,1);

%iterate through the data to split it up
cust_id = in_data(1,6);


for (row_iter = 1:n_rows)
    
    %check to make sure not last record

    
    %store unique results
    %------------------------------------------------------------------
    %check to see if cust_ids unique
    
    if cust_id == in_data(row_iter,6)
        
        %check to see if vin unique
        
        %store unique results in temp_storage
        temp_storage = [temp_storage; in_data(row_iter,:)];

        %debugging code
        debug = [debug; in_data(row_iter,:)];     


       
        
    else
        
        %INSERT PIPELINE HERE
        d = temp_storage(:,11);
        [new, indexer] = dataTransform(temp_storage(:,11));
        
        
        
        
        temp_storage = zeros(0,n_columns);
        temp_storage = [temp_storage; in_data(row_iter,:)];
        debug = [debug; in_data(row_iter,:)]; 
    end
    
    cust_id = in_data(row_iter,6);
    
end
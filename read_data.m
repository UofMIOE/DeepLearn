% Requires: INMARKETTIMING_S1 -> INMARKETTIMING_S5 
% Modifies: None
% Effects: Creates new matrix that is combination of all input data

%Reading Input Data
%Combines all input data to one matrix

%Read in "INMARKETTIMING_S1"
file_1_input = 'INMARKETTIMING_S1.csv';
file_1 = xlsread(file_1_input)

%Read in "INMARKETTIMING_S2"
file_2_input = 'INMARKETTIMING_S2.csv';
file_2 = xlsread(file_2_input)

%Read in "INMARKETTIMING_S3"
file_3_input = 'INMARKETTIMING_S3.csv';
file_3 = xlsread(file_3_input)

%Read in "INMARKETTIMING_S4"
file_4_input = 'INMARKETTIMING_S4.csv';
file_4 = xlsread(file_4_input)

%Read in "INMARKETTIMING_S5"
file_5_input = 'INMARKETTIMING_S5.csv';
file_5 = xlsread(file_5_input)

%All Input Data Combined
all_data = [file_1; file_2; file_3; file_4; file_5]








%-----------------------------------------------------------------------------------------------------------------------
% Load Training data.
%-----------------------------------------------------------------------------------------------------------------------

function [ x, t ] = test_load_training_data ()

    file_path               = 'R:\Projects\MATLAB\numerai\solution_1\data\source\';
    file_name_training_data = 'numerai_training_data.csv';
    file_name               = strcat ( file_path, file_name_training_data );

    file_data = readtable ( file_name );

    x = table2array ( file_data (:,1:21) )';
    t = table2array ( file_data (:,22  ) )';

end 
%-------------------------------------------------------------------------------------------------------------------------------
%
%-------------------------------------------------------------------------------------------------------------------------------

classdef ApplicationNumeraiSolution1
    
    %-----------------------------------------------------------------------------------------------------------------------
    % CONSTANTS
    %-----------------------------------------------------------------------------------------------------------------------

    properties ( Constant )
        
        % File management.
        
        FILE_PATH_INPUT                = 'R:\Projects\common_matlab\application\numerai\solution_1\data\source\';
        FILE_PATH_OUTPUT               = 'R:\Projects\common_matlab\application\numerai\solution_1\data\solution\';
        FILE_NAME_TRAINING_DATA        = 'numerai_training_data.csv';                        
        FILE_NAME_APPLICATION_DATA     = 'numerai_tournament_data.csv'; 
        FILE_NAME_LIVE_DATA            = 'numerai_live_data.csv'; 
        FILE_NAME_PREDICTIONS          = 'matlab_predictions.csv'; 
        
        % Data cluster configuration.
        
        CLASSIFIER_DIMENTION_1 = 1;
        CLASSIFIER_DIMENTION_2 = 1;
        CLASSIFIER_DIMENTION_3 = 1;
        
        % Neural network configuration.
        
        ANN_HIDDEN_UNITS                = 3;
        ANN_MULTINET_NETWORK_COUNT      = 2;
        ANN_MULTINET_NETWORK_COUNT_BEST = 1;
        ANN_GLOBAL_BIAS                 = -0.002;
        
    end
    
    %-----------------------------------------------------------------------------------------------------------------------
    % PROPERTIES
    %-----------------------------------------------------------------------------------------------------------------------
    
    properties
    end
    
    %-----------------------------------------------------------------------------------------------------------------------
    % METHODS
    %-----------------------------------------------------------------------------------------------------------------------
    
    methods
        
        %-----------------------------------------------------------------------------------------------------------------------
        % run
        %-----------------------------------------------------------------------------------------------------------------------
        
        function run ( this )
            
            % Initialize application.
            
            StaticUtility.console_message ( 0, 1, 'Initializing application.' );
            
                StaticUtility.initialize_console ();            
                
            
            % Load training data.
            
            StaticUtility.console_message ( 0, 1, 'Loading training data.' );
            
                [ xt, t ] = this.load_traning_data();
                
            % Load application data.
            
            StaticUtility.console_message ( 0, 1, 'Loading application data.' );
            
                [ id, x ] = this.load_application_data();
                
            % Classify data.
            
            StaticUtility.console_message ( 0, 1, 'Computing data clusters.' );
                
                cluster_dimention_1 = this.CLASSIFIER_DIMENTION_1;
                cluster_dimention_2 = this.CLASSIFIER_DIMENTION_2;
                cluster_dimention_3 = this.CLASSIFIER_DIMENTION_3;
                
                cluster_net = ClusterNet ( cluster_dimention_1, cluster_dimention_2, cluster_dimention_3 );
                
                cluster_net.train   ( xt );
                cluster_net.compute ( xt );                
            
            % Train neural cluster networks.
            
            StaticUtility.console_message ( 0, 1, 'Training cluster networks.' );
            
                % Cluster parameters.
                
                cluster_count = cluster_dimention_1 * cluster_dimention_2 * cluster_dimention_3; 
            
                % Neural network parameters.
            
                hidden_layer_size  = this.ANN_HIDDEN_UNITS;
                network_count      = this.ANN_MULTINET_NETWORK_COUNT;
                network_count_best = this.ANN_MULTINET_NETWORK_COUNT_BEST;                
                
                network_array = cell ( 1, cluster_count );
                
                for i = 1:cluster_count
                
                    StaticUtility.console_message ( 0, 1, horzcat ( 'Training cluster ', num2str ( i ), '/', num2str ( cluster_count ), '.' ));
                    
                    % Create a new neural network for this cluster.
                    
                    network_array{i} = MultiNet ( hidden_layer_size, network_count, network_count_best ); 
                    
                    % Select data cluster.
                    
                    [ xci, tci ] = cluster_net.select_training_cluster ( i, xt, t );
                    
                    % TRain neural network on selected cluster.
                    
                    network_array{i}.train ( xci, tci );
                    
                end           
            
            % Compute network
            
            StaticUtility.console_message ( 0, 1, 'Computing network output.' );
            
                % Compute cluster membership.
                
                cluster_net.compute ( x );  
            
                % Compute that cluster neural networks.
                
                idc = [];
                yc  = [];
                
                for i = 1:cluster_count
                
                    % Select cluster and compute outputs.
                    
                    [ idci, xci ] = cluster_net.select_cluster ( i, id, x );
                    yci = network_array{i}.compute_best ( xci );
                    idc = [ idc idci ];
                    yc  = [ yc  yci  ];
                    
                end               
            
            % Save solution to file.    
            
            StaticUtility.console_message ( 0, 1, 'Compute post training bias.' );
            
                yc = yc(:,:) + this.ANN_GLOBAL_BIAS;
                
            % Save solution to file.
            
            StaticUtility.console_message ( 0, 1, 'Saving application solution.' );
            
                this.save_application_solution ( idc, yc );
                
            
            % Clean up and exit application
                        
            StaticUtility.console_message ( 0, 1, 'Complete.' );            
        end
       
        
        %-----------------------------------------------------------------------------------------------------------------------
        % Load Training data.
        %-----------------------------------------------------------------------------------------------------------------------
    
        function [ x, t ] = load_traning_data ( this )
    
            file_path               = this.FILE_PATH_INPUT;
            file_name_training_data = this.FILE_NAME_TRAINING_DATA;
            file_name               = strcat ( file_path, file_name_training_data );
            
            file_data = readtable ( file_name );
            
            x = table2array ( file_data (:,1:21) )';
            t = table2array ( file_data (:,22  ) )';
            
        end  
        
        %-----------------------------------------------------------------------------------------------------------------------
        % Load Application data.
        %-----------------------------------------------------------------------------------------------------------------------
    
        function [ id, x ] = load_application_data ( this )
    
            file_path                  = this.FILE_PATH_INPUT;            
            file_name_application_data = this.FILE_NAME_APPLICATION_DATA;
            file_name                  = strcat ( file_path, file_name_application_data );
            
            file_data = readtable ( file_name );
            
            x  = table2array ( file_data (:,2:22) )';
            id = table2array ( file_data (:,1   ) )';
            
        end  
        
        %-----------------------------------------------------------------------------------------------------------------------
        % Save application solutions.
        %-----------------------------------------------------------------------------------------------------------------------
    
        function save_application_solution ( this, id, y )
    
            file_path                      = this.FILE_PATH_OUTPUT;            
            file_name_application_solution = this.FILE_NAME_PREDICTIONS;
            file_name                      = strcat ( file_path, file_name_application_solution );
            
            t_id        = id';
            probability = y';
            file_data = table ( t_id, probability );
            
            writetable ( file_data, file_name ); 
            
        end  
        
    end
    
end


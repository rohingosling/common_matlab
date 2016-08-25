%---------------------------------------------------------------------------------------------------------------------------
% CLASS: MultiNet
%---------------------------------------------------------------------------------------------------------------------------

classdef MultiNet < handle
    
    %---------------------------------------------------------------------------------------------------------------------------
    % CONSTANTS
    %---------------------------------------------------------------------------------------------------------------------------
    
    properties ( Constant )
    
        % Neural network configuration
        
        TRAINING_ALGORYTHM_SCG             = 'trainscg';        % Scaled Conjugate Gradient     
        TRAINING_ALGORYTHM_LM              = 'trainlm';         % Levenberg-Marquardt
        TRAINING_ALGORYTHM_BR              = 'trainbr';         % Bayesian regularization
        PERFROMANCE_FUNCTION_MSE           = 'mse';
        PERFROMANCE_FUNCTION_CROSS_ENTROPY = 'crossentropy';        
        HIDDEN_LAYER_SIZE                  = 6;
        NETWORK_COUNT                      = 6;
        NETWORK_COUNT_BEST                 = 3;
        TRAINING_RATIO                     = 60/100;
        TRAINING_VALIDATION_RATIO          = 39/100;
        TRAINING_TEST_RATIO                = 1/100;        
        
        % Table and matrix referencing.
           
        FIELD_PERFORMANCE   = 1;
        FIELD_NETWORK_INDEX = 2;        
        
        % Text.
                
        NEW_LINE_TRUE  = StaticUtility.NEW_LINE_TRUE;
        NEW_LINE_FALSE = StaticUtility.NEW_LINE_FALSE;
        
        % Audio feedback
        
        SOUND_VOLUME      = 0.05;
        %SOUND_VOLUME      = 0.0;
        SOUND_FREQUENCY_1 = 500;
        SOUND_FREQUENCY_2 = 6000;
        SOUND_FREQUENCY_3 = 12000;
        SOUND_PERIOD_1    = 10;
        SOUND_PERIOD_2    = 50;
        SOUND_PERIOD_3    = 100;
    end

    %---------------------------------------------------------------------------------------------------------------------------
    % PROPERTIES
    %---------------------------------------------------------------------------------------------------------------------------    
    
    properties
        
        % Initialize nerual network parameters.

        hidden_layer_size         = MultiNet.HIDDEN_LAYER_SIZE;                        
        training_algorythm        = MultiNet.TRAINING_ALGORYTHM_BR;         
        perfromance_function      = MultiNet.PERFROMANCE_FUNCTION_MSE; 
        training_ratio            = MultiNet.TRAINING_RATIO;
        training_validation_ratio = MultiNet.TRAINING_VALIDATION_RATIO;
        training_test_ratio       = MultiNet.TRAINING_TEST_RATIO;
        
        % Initialise multi-net parameters.
        
        network_count      = MultiNet.NETWORK_COUNT;
        network_count_best = MultiNet.NETWORK_COUNT_BEST;
        
        % Performance metrics
        
        performance_average;
        performance_best;
        performance_best_average;
        
        % Neural networks;
        
        network_list;
        network_list_index;
        
    end
    
    %---------------------------------------------------------------------------------------------------------------------------
    % METHODS
    %---------------------------------------------------------------------------------------------------------------------------
    
    methods
        
        %-----------------------------------------------------------------------------------------------------------------------
        % Constructor
        %-----------------------------------------------------------------------------------------------------------------------
        
        function this = MultiNet ( hidden_layer_size, network_count, network_count_best )
            
            % Initialize multi-net parameters.
            
            this.hidden_layer_size  = hidden_layer_size;
            this.network_count      = network_count;
            this.network_count_best = network_count_best;
            
            % Initialize network.
            
            this.initialize ();
        end
        
        %-----------------------------------------------------------------------------------------------------------------------
        % Initialize the multi-net.
        %-----------------------------------------------------------------------------------------------------------------------
        
        function initialize ( this )
            
            StaticUtility.console_message ( 1, 1, 'Initialize multi-net.' );
            StaticUtility.play_delay_tone ( this.SOUND_FREQUENCY_3, this.SOUND_PERIOD_1, this.SOUND_VOLUME, 100, 1 );
            
            % Build neural network.
            
            network = patternnet ( this.hidden_layer_size, this.training_algorythm, this.perfromance_function );            
            %network = fitnet ( this.hidden_layer_size, this.training_algorythm );
            %network = fitnet ( this.hidden_layer_size );            
            
            % Configure Division of Data for Training, Validation, Testing

            network.divideParam.trainRatio = this.training_ratio;
            network.divideParam.valRatio   = this.training_validation_ratio;
            network.divideParam.testRatio  = this.training_test_ratio;
            
            % Initialize network list.
            
            this.network_list       = cell ( this.network_count, 1 );
            this.network_list_index = cell ( this.network_count, 2 );       % perfromance, index
            
            for i = 1 : this.network_count                
                this.network_list { i } = network;
            end
        end
        
        %-----------------------------------------------------------------------------------------------------------------------
        % Execute training sequence.
        %-----------------------------------------------------------------------------------------------------------------------
        
        function train ( this, x, t )
            
            StaticUtility.console_message ( 1, 1, horzcat ( 'Training ', num2str ( this.network_count ), ' neural networks.'));
            StaticUtility.play_delay_tone ( this.SOUND_FREQUENCY_3, this.SOUND_PERIOD_1, this.SOUND_VOLUME, 50, 4 );
            
            % Train networks.      
                        
            performance_test_average = this.train_networks ( x, t );
            
            % Sort network index list.
            
            this.network_list_index = sortrows ( this.network_list_index );
            
            % List best performing networks.
            
            [ performance_best_average, performance_best ] = this.list_best_networks ( x, t );
            
            % Update class members.
            
            this.performance_average      = performance_test_average;
            this.performance_best         = performance_best;
            this.performance_best_average = performance_best_average;
            
            StaticUtility.play_delay_tone ( 12000, 10, this.SOUND_VOLUME, 100, 1 );  
            
            % Report training results.
            
            this.report();
        end
        
        %-----------------------------------------------------------------------------------------------------------------------
        % Train neural netowrk list.
        %-----------------------------------------------------------------------------------------------------------------------
        
        function performance_test_average = train_networks ( this, x, t ) 
            
            % Train networks.
            
            performance_test         = 1.0;
            performance_test_best    = 1.0;            
            performance_test_sum     = 0.0;
            performance_test_average = 0.0;
            
            for i =  1 : this.network_count                
                
                StaticUtility.play_delay_tone ( this.SOUND_FREQUENCY_1, this.SOUND_PERIOD_1, this.SOUND_VOLUME, 100, 2 );
                
                % Train current network.                 
                
                network                      = init ( this.network_list { i } );
                [ network, training_record ] = train ( network, x, t );
                this.network_list { i }      = network;
                
                % Record test perfromance.
                
                performance_test      = training_record.best_tperf;
                performance_test_sum  = performance_test_sum + performance_test;
                                
                % Index network performance.

                this.network_list_index { i, this.FIELD_PERFORMANCE   } = performance_test;
                this.network_list_index { i, this.FIELD_NETWORK_INDEX } = i;
                
                % Update best network trained so far.
                
                if performance_test < performance_test_best

                    StaticUtility.console_message ( 2, 0, horzcat ( 'Tranining network ', num2str ( i ), '/', num2str ( this.network_count ) ));                
                    fprintf ( horzcat ( '\t( P = ', num2str ( training_record.best_perf  ), ', ') );
                    fprintf ( horzcat ( 'Pv = ',    num2str ( training_record.best_vperf ), ', ') );
                    fprintf ( horzcat ( 'Pt = ',    num2str ( training_record.best_tperf ), ' ) ') );
                    fprintf ( '\n');
                    StaticUtility.play_delay_tone ( this.SOUND_FREQUENCY_2, this.SOUND_PERIOD_1, this.SOUND_VOLUME, 60, 3 );                

                    performance_test_best = performance_test;
                end
            end 
            
            % Compute average perfromance.
            
            performance_test_average = performance_test_sum / this.network_count; 
        end
        
        %-----------------------------------------------------------------------------------------------------------------------
        % List best performaing networks.
        %-----------------------------------------------------------------------------------------------------------------------
        
        function [ performance_average, performance_best ] = list_best_networks ( this, x, t )
            
            StaticUtility.console_message ( 1, 1, horzcat ( 'List best ', num2str ( this.network_count_best ), ' neural networks.'));
            
            % List networks.
            
            performance_best = 1.0;
            performance_sum  = 0.0;
            performance      = 0.0;            
            
            for i = 1 : this.network_count_best
                
                index           = cell2mat ( this.network_list_index ( i, this.FIELD_NETWORK_INDEX ) );
                performance     = cell2mat ( this.network_list_index ( i, this.FIELD_PERFORMANCE   ) );
                performance_sum = performance_sum + performance;

                StaticUtility.console_message ( 2, 0, horzcat ( num2str ( i ), ': Neural network ', num2str ( index ), '/', num2str ( this.network_count ) ));

                fprintf ( horzcat ( '\t( Perfromance = ', num2str ( performance ), ' )\n') );               
                StaticUtility.play_delay_tone ( this.SOUND_FREQUENCY_3, this.SOUND_PERIOD_1, this.SOUND_VOLUME, 100, 1 );
                
                % Update best performing network.
                
                if performance < performance_best                
                    performance_best = performance;
                end
            end
            
            % Compute average network perfromance..
            
            performance_average = performance_sum / this.network_count_best;  
            
        end
        
        %-----------------------------------------------------------------------------------------------------------------------
        % Report training and testing results.
        %-----------------------------------------------------------------------------------------------------------------------
                
        function report ( this )
            
            StaticUtility.console_message ( 1, 1, horzcat ( 'Average Test Performance, out of      ', num2str(this.network_count     ), '\t= ', num2str ( this.performance_average      ) ) );
            StaticUtility.console_message ( 1, 1, horzcat ( 'Best Test Performance, out of         ', num2str(this.network_count     ), '\t= ', num2str ( this.performance_best         ) ) );
            StaticUtility.console_message ( 1, 1, horzcat ( 'Average Test Performance, out of best ', num2str(this.network_count_best), '\t= ', num2str ( this.performance_best_average ) ) );
            
            %outputs     = net      ( inputs );
            %errors      = gsubtract( targets, outputs );
            %performance = perform  ( net, targets, outputs );

            % Plots
            %view(net)
            %figure, plotperform(tr)
            %figure, plottrainstate(tr)
            %figure, plotconfusion(targets,outputs)
            %figure, plotroc(targets,outputs)
            %figure, ploterrhist(errors)
        end
        
        %-----------------------------------------------------------------------------------------------------------------------
        %  Compute best network output.
        %-----------------------------------------------------------------------------------------------------------------------
                
        function y = compute ( this, x )
                
            y = this.compute_network_range ( x, 1, this.network_count );
            
        end  
        
        %-----------------------------------------------------------------------------------------------------------------------
        %  Compute best network output.
        %-----------------------------------------------------------------------------------------------------------------------
                
        function y = compute_best ( this, x )
            
            % Compute networks.
            
            y_sum     = 0.0;
            y_average = 0.0;            
            
            for i = 1 : this.network_count_best
                
                index = this.network_list_index { i, this.FIELD_NETWORK_INDEX };
                yi    = this.network_list { index } ( x );                
                y_sum = y_sum + yi;
                
            end
            
            % Compute average output across selected netowrks.
            
            y_average = y_sum / this.network_count_best;
            
            % return average output to caller.
            
            y = y_average;
            
        end  
              
    end              
end


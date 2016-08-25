
classdef SolutionPipeline
    
    %---------------------------------------------------------------------------------------------------------------------------
    % PROPERTIES
    %---------------------------------------------------------------------------------------------------------------------------
    
    properties
    end
    
    %---------------------------------------------------------------------------------------------------------------------------
    % METHODS
    %---------------------------------------------------------------------------------------------------------------------------
    
    methods
        
        %-----------------------------------------------------------------------------------------------------------------------
        % Compute vector ranges.
        %-----------------------------------------------------------------------------------------------------------------------
        
        function vector_ranges = compute_vector_ranges ( this, vector )
            
            %  Retrieve vector size.
            
            [ row_count, col_count ] = size ( vector );
            
            % Compute vector rantes.

            for row_index = 1 : row_count
                
                data_max = max ( vector ( row_index, : ) );
                data_min = min ( vector ( row_index, : ) );
                
                vector_ranges ( row_index, : ) = data_max - data_min;                
            end
        end
        
        %-----------------------------------------------------------------------------------------------------------------------
        % Compute vector magnitudes.
        %-----------------------------------------------------------------------------------------------------------------------
        
        function vector_magnitudes = compute_vector_magnitudes ( this, vector )
            
            %  Retrieve vector size.
            
            [ row_count, col_count ] = size ( vector );
            
            % Compute vector magnitudes.
            
            for row_index = 1 : row_count
                
                row = vector ( row_index, : );
                vector_magnitudes ( row_index, : ) = norm ( row );
                
            end
        end
        
        %-----------------------------------------------------------------------------------------------------------------------
        % Compute reciprocal target vector.
        %-----------------------------------------------------------------------------------------------------------------------
        
        function reciprocal_target_vectors = compute_reciprocal_target_vectors ( this, target_vector )
            
            %  Retrieve vector size.
            
            [ row_count, col_count ] = size ( target_vector );
            
            % Compute reciprical target vector matrix.
            
            for row_index = 1 : row_count
                
                target = target_vector ( row_index, : );

                if target == 0 
                    reciprocal_target_vectors ( row_index, : ) = [ 1 0 ];
                else
                    reciprocal_target_vectors ( row_index, : ) = [ 0 1 ];
                end
            end
        end
    end
end


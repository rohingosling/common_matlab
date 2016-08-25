%---------------------------------------------------------------------------------------------------------------------------
% CLASS: MultiNet
%---------------------------------------------------------------------------------------------------------------------------

classdef ClusterNet < handle
    
    %---------------------------------------------------------------------------------------------------------------------------
    % CONSTANTS
    %---------------------------------------------------------------------------------------------------------------------------
    
    properties ( Constant )
        
        % Neural network configuration
        
        DIMENTION_1 = 2;
        DIMENTION_2 = 2;
        DIMENTION_3 = 2;        
    end

    %---------------------------------------------------------------------------------------------------------------------------
    % PROPERTIES
    %---------------------------------------------------------------------------------------------------------------------------    
    
    properties
        
        dimension1 = ClusterNet.DIMENTION_1;
        dimension2 = ClusterNet.DIMENTION_2;
        dimension3 = ClusterNet.DIMENTION_3;        
        
        network;
        cluster_index_map;
        
    end
    
    %---------------------------------------------------------------------------------------------------------------------------
    % METHODS
    %---------------------------------------------------------------------------------------------------------------------------
    
    methods
        
        %-----------------------------------------------------------------------------------------------------------------------
        % Constructor
        %-----------------------------------------------------------------------------------------------------------------------
        
        function this = ClusterNet ( dimension1, dimension2, dimension3 )

            % Initialize network.
            
            this.initialize ( dimension1, dimension2, dimension3 );
        end
        
        %-----------------------------------------------------------------------------------------------------------------------
        % Initialize the multi-net.
        %-----------------------------------------------------------------------------------------------------------------------
        
        function initialize ( this, dimension1, dimension2, dimension3 )

            %this.network = selforgmap ( [ dimension1 dimension2 dimension3], 100, 3, 'randtop', 'linkdist' );
            this.network = selforgmap ( [ dimension1 ], 100, 3, 'randtop', 'linkdist' );
            
        end
        
        %-----------------------------------------------------------------------------------------------------------------------
        % Execute training sequence.
        %-----------------------------------------------------------------------------------------------------------------------
        
        function training_record = train ( this, x )
            
            % TRain network
            
            [ this.network, training_record ] = train ( this.network, x );
            
            % Report training results.
            
            this.report();
        end
        
        %-----------------------------------------------------------------------------------------------------------------------
        % Report training and testing results.
        %-----------------------------------------------------------------------------------------------------------------------
                
        function report ( this )
        end
        
        %-----------------------------------------------------------------------------------------------------------------------
        %  Compute best network output.
        %-----------------------------------------------------------------------------------------------------------------------
                
        function compute ( this, x )
            
            % Compute network.
            
            cluster = this.network ( x );
            
            % Compute cluster index.
            
            this.cluster_index_map = this.cluster_to_index ( cluster );
            
        end
        
        %-----------------------------------------------------------------------------------------------------------------------
        %  Divide data into clusters for nerual network training.
        %-----------------------------------------------------------------------------------------------------------------------
                
        function [xci, tci] = select_training_cluster ( this, cluster_index, x, t )
            
            % Pre-format data for cluster filtering.
            
            c = this.cluster_index_map;            
            xc = [ c; x ];
            tc = [ c; t ];
            
            % Filter out the cluster selected via the cluster index.
            
            xci = xc ( 2:end, xc(1,:) == cluster_index );
            tci = tc ( 2:end, tc(1,:) == cluster_index );
            
        end
        
        %-----------------------------------------------------------------------------------------------------------------------
        %  Divide data into clusters for nerual network training.
        %-----------------------------------------------------------------------------------------------------------------------
                
        function [ idci, xci ] = select_cluster ( this, cluster_index, id, x )
            
            % Pre-format data for cluster filtering.
            
            c   = this.cluster_index_map;            
            idc = [ c; id ];
            xc  = [ c; x  ];
            
            % Filter out the cluster selected via the cluster index.
            
            idci = idc ( 2:end, idc(1,:) == cluster_index );
            xci  = xc  ( 2:end, xc (1,:) == cluster_index );
            
        end
        
        %-----------------------------------------------------------------------------------------------------------------------
        %  Convert cluster to index.
        %-----------------------------------------------------------------------------------------------------------------------
                
        function index = cluster_to_index ( this, cluster )
            
            % Alocate memory for the working index array.
            
            [ row_count, col_count ] = size ( cluster );
            
            y = zeros ( 1, col_count );
            
            % Compute indicies.
            
            for s = 1 : col_count
            
                y_sum = 0.0;
                for i = 1 : row_count
                    y_sum = y_sum + i*cluster(i,s);
                end
                
                y(1,s) = y_sum;
            end
            
            % return indicies to caller.
            
            index = y;
        end
    end              
end



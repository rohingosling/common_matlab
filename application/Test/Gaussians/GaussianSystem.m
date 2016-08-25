function GaussianSystem ()

    % Calculate function constraints.

    i    = 0.1;
    xMin = -5.0;    
    xMax =  5.0;
    
    % Specify distribution domain.
        
    x = xMin : i : xMax;    
    
    % Calculate displacement.
    
    xd  = 1.5;
    xd0 =  xd;
    xd1 = -xd;
    
    % Calculate indevidual distributions.
    
    y0 = Gaussian ( x, xd0, 1.0 );
    y1 = Gaussian ( x, xd1, 1.0 );
    
    % Calculate Distribution system.
    
    y  = y0 + y1;
    
    % plot graph
    
    plotGraph = boolean (1);    
    if plotGraph       
        
        hold on;
        
        % plot axies
    
        xAxisMin      = xMin;
        xAxisMax      = xMax;    
        yAxisMin      = -1.0;
        yAxisMax      =  2.0;
        xAxis         = [ xAxisMin, xAxisMax ];
        yAxis         = [ yAxisMin, yAxisMax  ];
        axisColor     = [ 0.0, 0.0, 0.0 ];
        axisLineStyle = ':';
    
        axis ( [ xAxisMin, xAxisMax, yAxisMin, yAxisMax ] );    
        set  ( gca, 'XTick', xAxisMin : 1 : xAxisMax );
        set  ( gca, 'YTick', yAxisMin : 0.25 : yAxisMax );
        plot ( xAxis, [ 0, 0 ], 'color', axisColor, 'LineStyle', axisLineStyle );
        plot ( [ 0, 0 ], yAxis, 'color', axisColor, 'LineStyle', axisLineStyle );
        
        % plot function    
    
        functionColor = 'red';
        plot ( x, y0, 'color', functionColor );
        
        functionColor = 'blue';
        plot ( x, y1, 'color', functionColor );
        
        functionColor = 'black';
        plot ( x, y, 'color', functionColor );
    
        hold off;
    end

end


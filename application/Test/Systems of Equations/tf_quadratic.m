function plot_function ()

    % Plot axies

    plot_axis;
    
    x0 = linspace ( -1.0, 0.0 );
    x1 = linspace (  0.0, 1.0 );
    
    % Plot transfer function.
    
    y0 =  x0*(x0-2);
    y1 = -x1*(x1-2);    
    plot ( x0, y0, 'LineWidth', 1, 'Color', 'b', 'LineStyle', '-' );
    plot ( x1, y1, 'LineWidth', 1, 'Color', 'b', 'LineStyle', '-' );
    
    % Plot derivitive.
    
    %y = 5*k.a*x.^4 + 4*k.b*x.^3 + 3*k.c*x.^2 + 2*k.d*x + k.e;
    %plot ( x, y, 'LineWidth', 1, 'Color', 'r', 'LineStyle', '-' );

end

function plot_axis ()
    showAxis = boolean (1);
    
    if  showAxis
        
        r      = 1.0;
        xmin   = -1.0;
        xmax   =  1.0;
        ymin   =  0.0;
        ymax   =  1.0;
        i      =  0.25;
        margin = i;        
        
        clf;        
        hold on;
        
        axis ( [ -r-margin, r+margin, -r-margin, r+margin ] );
        axis equal;
        
        set  ( gca, 'XTick', xmin - margin : i : xmax + margin );
        set  ( gca, 'YTick', ymin - margin : i : ymax + margin );
        set  ( gca, 'GridLineStyle', '-' );
        set  ( gca, 'XLim', [ xmin-margin xmax+margin ], 'YLim', [ ymin-margin ymax+margin ] );
        set  ( gca, 'xcolor', [.8 .8 .8], 'ycolor', [.8 .8 .8] );        
        plot ( [ xmin-margin, xmax+margin ], [ 0, 0 ], 'LineWidth', 1, 'Color', 'k', 'LineStyle', ':' );
        plot ( [ 0, 0 ], [ ymin-margin, ymax+margin ], 'LineWidth', 1, 'Color', 'k', 'LineStyle', ':' );
        grid on;
    end
end




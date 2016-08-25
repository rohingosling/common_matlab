function plot_activation_function ()

    % Plot axies

    plot_axis;
    
    % Plot transfer function.
    
%     for x = -4 : 0.01 : 4                
%         y = oscillator_circular_1 ( x );
%         plot ( x, y, 'LineWidth', 1, 'Color', 'red', 'LineStyle', '-' );
%     end
%     
%     for x = -4 : 0.01 : 4                
%         y = oscillator_circular_2 ( x );
%         plot ( x, y, 'LineWidth', 1, 'Color', 'blue', 'LineStyle', '-' );
%     end
%     
%     for t = 0 : 0.01 : 4
%         x = oscillator_circular_2 ( t );
%         y = oscillator_circular_1 ( t );
%         plot ( x, y, 'LineWidth', 1, 'Color', 'black', 'LineStyle', '-' );
%     end

    for x = -4 : 0.01 : 4                
        y = oscillator_quadratic_1 ( x );
        plot ( x, y, 'LineWidth', 1, 'Color', 'blue', 'LineStyle', '-' );
    end
    
    for x = -4 : 0.01 : 4                
        y = oscillator_quadratic_2 ( x );
        plot ( x, y, 'LineWidth', 1, 'Color', 'red', 'LineStyle', '-' );
    end
    
    for t = 0 : 0.01 : 4
        x = oscillator_quadratic_1 ( t );
        y = oscillator_quadratic_2 ( t );
        plot ( x, y, 'LineWidth', 1, 'Color', 'black', 'LineStyle', '-' );
    end

%     for x = -2 : 0.01 : 2                
%         y = quadratic ( x );
%         plot ( x, y, 'LineWidth', 1, 'Color', 'black', 'LineStyle', '-' );
%     end
    
%     for x = -2 : 0.01 : 2                
%         y = pythagorian ( x );
%         plot ( x, y, 'LineWidth', 1, 'Color', 'red', 'LineStyle', '-' );
%     end   
    
end

function fx = oscillator_quadratic_1 ( x )

    % Wrap domain.

    if ( x >= 2 )
        t = -2 + ( x - 2 )
    end
    
    if ( x < -2 )
        t = 2 - ( -2 - x )
    end
    
    if ( x >= -2 ) && ( x < 2 )
        t = x;        
    end

    % Compute function.
    
    if ( t >= -2 ) && ( t < -1 )
        y = (t+2)^2 - 1;
    end
    
    if ( t >= -1.0 ) && ( t < 1 )
        y = 1 - t^2;
    end
    
    if ( t >= 1 ) && ( t < 2 )
        y = (t-2)^2 - 1;
    end

    fx = y;

end

function fx = oscillator_quadratic_2 ( x )

    fx = oscillator_quadratic_1 ( x-1 );
    
end

function fx = quadratic ( x )

    if ( x >= -1 ) && ( x < 0 )
        y = x.*(x+2);
    end

    if ( x >= 0  ) && ( x <= 1 )    
        y = -x.*(x-2);
    end

    if ( x >= 1 )
        y = 1;
    end

    if ( x <= -1 )
        y = -1;
    end

    fx = y;
end

function fx = parabolic ( x )

    if ( x >= -1 )
        y = ((x+1)^2)/2 - 1;
    else
        y = -1;
    end

    fx = y;

end

function fx = transposed_quadratic ( x )

    if ( x >= -1 ) && ( x < 0 )
        y = sqrt(x+1)-1;
    end

    if ( x >= 0  ) && ( x <= 1 )    
        y = -sqrt(-(x-1))+1;
    end

    if ( x >= 1 )
        y = 1;
    end

    if ( x <= -1 )
        y = -1;
    end

    fx = y;

end

function fx = oscillator_circular_1 ( x )

    % Wrap domain.

    if ( x >= 2 )
        t = -2 + ( x - 2 )
    end
    
    if ( x < -2 )
        t = 2 - ( -2 - x )
    end
    
    if ( x >= -2 ) && ( x < 2 )
        t = x;        
    end

    % Compute function.
    
    if ( t >= -2 ) && ( t < 0 )
        y = -sqrt( -t.*(t+2) );
    end

    if ( t >= 0  ) && ( t <= 2 )    
        y = sqrt( -t.*(t-2) );
    end

    if ( t >= 2 )
        y = 1;
    end

    if ( t <= -2 )
        y = -1;
    end

    fx = y;

end

function fx = oscillator_circular_2 ( x )

    % Wrap domain.

    if ( x >= 2 )
        t = -2 + ( x - 2 )
    end
    
    if ( x < -2 )
        t = 2 - ( -2 - x )
    end
    
    if ( x >= -2 ) && ( x < 2 )
        t = x;        
    end
    
    % Compute function.

    if ( t >= -2 ) && ( t < -1  )
        y = -sqrt( 1 - (t+2)^2 );
    end

    if ( t >= -1  ) && ( t <= 1 )    
        y = sqrt( 1 - t^2 );
    end
    
    if ( t >= 1 ) && ( t < 2  )
        y = -sqrt( 1 - (t-2)^2 );
    end

    fx = y;

end

function fx = pythagorian ( x )

   if ( x >= -1 ) && ( x < 0 )
        y = -sqrt( -x.*(x+2) );
    end

    if ( x >= 0  ) && ( x <= 1 )    
        y = sqrt( -x.*(x-2) );
    end

    if ( x >= 1 )
        y = 1;
    end

    if ( x <= -1 )
        y = -1;
    end

    fx = y;

end

function fx = parabolic ( x )

    if ( x >= -1 )
        y = ((x+1)^2)/2 - 1;
    else
        y = -1;
    end

    fx = y;

end

function plot_axis ()
    showAxis = boolean (1);
    
    if  showAxis
        
        r      = 1.0;
        xmin   = -4.0;
        xmax   =  4.0;
        ymin   = -1.0;
        ymax   =  1.0;
        i      =  1.0
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
        plot ( [ xmin-margin, xmax+margin ], [ 0, 0 ], 'LineWidth', 1, 'Color', 'k', 'LineStyle', '-' );
        plot ( [ 0, 0 ], [ ymin-margin, ymax+margin ], 'LineWidth', 1, 'Color', 'k', 'LineStyle', '-' );
        grid on;
    end
end




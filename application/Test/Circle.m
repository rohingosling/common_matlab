% Example Call:
%
% Circle ( 0.0, 0.0, 1.0, '-' );

function Circle ( x, y, r, lineStyle )

    % Plot axies

    showAxis = boolean (1);
    
    if  showAxis
        
        margin = 1;        
        
        clf;        
        hold on;
        
        axis ( [ -r-margin, r+margin, -r-margin, r+margin ] );
        axis equal;
        
        set  ( gca, 'XTick', -r-margin : 1 : r+margin );
        set  ( gca, 'YTick', -r-margin : 1 : r+margin );
        set  ( gca, 'GridLineStyle', '-' );
        set  ( gca, 'XLim', [ -r-margin r+margin ], 'YLim', [ -r-margin r+margin ] );
        set  ( gca, 'xcolor', [.8 .8 .8], 'ycolor', [.8 .8 .8] );        
        plot ( [ -r-margin, r+margin ], [ 0, 0 ], 'LineWidth', 1, 'Color', 'k', 'LineStyle', ':' );
        plot ( [ 0, 0 ], [ -r-margin, r+margin ], 'LineWidth', 1, 'Color', 'k', 'LineStyle', ':' );
        grid on;
    end
    
    % plot circle.
    
    ti    = 32.0;
    t     = 0 : 2*pi/ti : 2*pi;
    xi = r * cos ( t ) + x;
    yi = r * sin ( t ) + y;
    plot ( xi, yi, 'LineWidth', 1, 'Color', 'k', 'LineStyle', lineStyle );
        
end
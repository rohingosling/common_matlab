function solve_system ()

    t = solve_poly;
    x = double(t);
    w = (size(t)-1 : -1 : 0)';
    
    fprintf ('\n');
    for i = 1 : size(t)
        fprintf ( '%d: %10.4f \n', w(i), x(i) );
    end
    fprintf ('\n');
end

function t = solve_poly

    syms a b c d e f

    % Input Constraints
    
    x0 = -1/2; y0 =   3/16;
    x1 =  1/2; y1 =  13/16;
    x2 = -1.0; y2 =  0.0;
    x3 =  1.0; y3 =  1.0;
    d0 =  0.0;
    d1 =  0.0;
    
    % System Constraints
    
    e0 = y0 ==   a*x0^5 +   b*x0^4 +   c*x0^3 +   d*x0^2 + e*x0 + f;
    e1 = y1 ==   a*x1^5 +   b*x1^4 +   c*x1^3 +   d*x1^2 + e*x1 + f;
    e2 = y2 ==   a*x2^5 +   b*x2^4 +   c*x2^3 +   d*x2^2 + e*x2 + f;
    e3 = y3 ==   a*x3^5 +   b*x3^4 +   c*x3^3 +   d*x3^2 + e*x3 + f;        
    e4 = d0 == 5*a*x2^4 + 4*b*x2^3 + 3*c*x2^2 + 2*d*x2   + e;
    e5 = d1 == 5*a*x3^4 + 4*b*x3^3 + 3*c*x3^2 + 2*d*x3   + e;
    
    % Solution
            
    k = solve     ( [ e0, e1, e2, e3, e4, e5 ], a, b, c, d, e, f );    
    t = transpose ( [ k.a, k.b, k.c, k.d, k.e, k.f ] );        
    
    plot_polynomial ( k )
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


function plot_polynomial ( k )

    % Plot axies

    plot_axis;
    
    x = linspace ( -1.0, 1.0 );
    
    % Plot transfer function.
    
    y = k.a*x.^5 + k.b*x.^4 + k.c*x.^3 + k.d*x.^2 + k.e*x + k.f;    
    plot ( x, y, 'LineWidth', 1, 'Color', 'b', 'LineStyle', '-' );
    
    % Plot derivitive.
    
    y = 5*k.a*x.^4 + 4*k.b*x.^3 + 3*k.c*x.^2 + 2*k.d*x + k.e;
    plot ( x, y, 'LineWidth', 1, 'Color', 'r', 'LineStyle', '-' );

end



function DrawFigure ()
    
    % Calculate function.
    
    r  = 1;
    xd = 0;
    yd = 0;
    a  = pi/2;
    
    [ x, y ] = Circle ( xd, yd, r, a );
    
    % Draw figure.
    
    margin = 0.5;
    figure;    
    plot ( x, y, 'LineWidth', 1, 'Color', 'black', 'LineStyle', '-' );    
    axis equal;
    axis ( [ -r-margin, r+margin, -r-margin, r+margin ] );
    
end
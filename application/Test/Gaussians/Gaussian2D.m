
function Z = Gaussian2D ( x, y, xd, yd, v )

    % Calculate variance and distribution factors.
    
    dv = 2 * v.^2;                  % Variance factor.
    a  = 1 / v * sqrt ( 2 * pi );   % Distribution factor.

    % Calculate displacement delta's
    
    dx = ( x - xd ).^2;
    dy = ( y - yd ).^2;
        
    % Calculate function exponent substetutions.
    
    ex = -dx/dv;
    ey = -dy/dv;
        
    % Calculate 3D Gaussian distribution.
    
    Z  = a.^( ex + ey );
    
end

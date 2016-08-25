
function y = Gaussian ( x, d, v )
    
    % Calculate variance and distribution factors.
    
    dv = 2 * v.^2;                  % Variance factor.
    a  = 1 / v * sqrt ( 2 * pi );   % Distribution factor.

    % Calculate displacement delta's
    
    dx = ( x - d ).^2;    
        
    % Calculate function exponent substetutions.
    
    ex = -dx/dv;    
        
    % Calculate 3D Gaussian distribution.
    
    y  = a.^ex;
    
end


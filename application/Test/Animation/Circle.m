
function [ xi, yi ] = Circle ( x, y, r, a )
   
    % Calculate function constraints.
    
    pi2 = 2*pi;
    ti  = 3;
    t   = 0 : pi2/ti : pi2;
    
    % Calculate function.
    
    xi = r * cos ( t + a ) + x;
    yi = r * sin ( t + a ) + y;
        
end
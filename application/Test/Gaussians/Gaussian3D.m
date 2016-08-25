
%--------------------------------------------------------------------------
% Decription:
%
% Input Arguments:
%
% - ( x y x )
%
%   Function space vector.
%
% - ( xd yd zd )
%
%   Displacement vector.
%
% - v
%
%   Gaussian distribution variance.
%
% Output Arguments:
%
% - Z
%   The result of the evaluated function.
%--------------------------------------------------------------------------

function Z = Gaussian3D ( x, y, z, xd, yd, zd, v )

    % Calculate variance and distribution factors.
    
    dv = 2 * v.^2;                  % Variance factor.
    a  = 1 / v * sqrt ( 2 * pi );   % Distribution factor.

    % Calculate displacement delta's
    
    dx = ( x - xd ).^2;
    dy = ( y - yd ).^2;
    dz = ( z - zd ).^2;
    
    % Calculate function exponent substetutions.
    
    ex = -dx/dv;
    ey = -dy/dv;
    ez = -dz/dv;
    
    % Calculate 3D Gaussian distribution.
    
    Z  = a.^( ex + ey + ez );
    
end



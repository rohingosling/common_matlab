function GaussianSystem2D ()

    % Function distribution.

    xRange = 10;
    yRange = 10;
    ZRange = 2;
    
    xMin = -xRange;    
    xMax =  xRange;
    yMin = -yRange;    
    yMax =  yRange;
    zMin =  0.0;    
    zMax =  ZRange;
    
    xi = 0.2;
    yi = 0.2;    

    % Initialize 3D mesh.
   
    [x,y] = meshgrid ( xMin:xi:xMax, yMin:yi:yMax );
    
    % Evaluate functions.   
    
    z0 = Gaussian2D ( x, y, -1.5, 0, 1 );
    z1 = Gaussian2D ( x, y,  1.5, 0, 1 );
    z2 = Gaussian2D ( x, y,  4,   3, 1 );
    
    z = z0 + z1 + z2;
    
    % plot function    
    
    figure;            
    surf ( x, y, z, 'FaceColor', 'interp' );    
    axis equal;
    axis( [ xMin, xMax, yMin, yMax, zMin, zMax ] );    
    
end


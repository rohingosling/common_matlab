function GaussianSystem3D ()

    % Function constraints.

    range = 7;
    
    xRange = range;
    yRange = range;
    ZRange = range;
    
    xMin = -xRange;    
    xMax =  xRange;
    yMin = -yRange;    
    yMax =  yRange;
    zMin = -ZRange;    
    zMax =  ZRange;
    
    i = 0.2;
    
    xi = i;
    yi = i;
    zi = i;
    
    % Set coordinates
    
    f0x =  1.5;
    f0y =  0.0;
    f0z =  0.0;
    
    f1x = -1.5;
    f1y =  0.0;
    f1z =  0.0;
    
    f2x =  4.0;
    f2y =  4.0;
    f2z =  0.0;
    
    f3x =  0.0;
    f3y =  0.0;
    f3z =  5.5;

    % Initialize 3D mesh.
   
    [ x, y, z ] = meshgrid ( xMin:xi:xMax, yMin:yi:yMax, zMin:zi:zMax );
    
    % Evaluate functions.   

    v = 1.0;

    f0 = Gaussian3D ( x, y, z, f0x, f0y, f0z, v );
    f1 = Gaussian3D ( x, y, z, f1x, f1y, f1z, v );
    f2 = Gaussian3D ( x, y, z, f2x, f2y, f2z, v );
    f3 = Gaussian3D ( x, y, z, f3x, f3y, f3z, v );

    f = f0 + f1 + f2 + f3;
    
    % plot function    
    
    figure;            
    isosurface ( x, y, z, f, 0.5 );        
    axis equal;
    axis( [ xMin, xMax, yMin, yMax, zMin, zMax ] ); 
    
end





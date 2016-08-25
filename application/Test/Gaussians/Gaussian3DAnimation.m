function Gaussian3DAnimation ()

    % Initialize command console.
    
    clc; 
    set ( gcf, 'currentch', char ( 1 ) );
    while ( ( get ( gcf, 'CurrentCharacter' )  )~= 27 ) pause ( 0.01 ); end    
    set ( gcf, 'currentch', char ( 1 ) );

    % Function constraints.

    range = 8;
    
    xRange = range;
    yRange = range;
    ZRange = range;
    
    xMin = -xRange;    
    xMax =  xRange;
    yMin = -yRange;    
    yMax =  yRange;
    zMin = -ZRange;    
    zMax =  ZRange;
    
    i = 1.0;       % Mesh resolution.
    
    xi = i;
    yi = i;
    zi = i;
    
    % Set coordinates
    
    f0x =  0.0;
    f0y =  0.0;
    f0z =  0.0;
    
    f1x =  0.0;
    f1y =  0.0;
    f1z =  0.0;
    
    f2x =  0.0;
    f2y =  0.0;
    f2z =  0.0;
    
    f3x =  0.0;
    f3y =  0.0;
    f3z =  0.0;
    
    f4x =  0.0;
    f4y =  0.0;
    f4z =  0.0;
    
    % Configure animation.
    
    t0 = 0;
    t1 = 0;
    t2 = 0;
    t3 = 0;
    t4 = 0;
    
    ti = 2*pi/150;
    
    ti0 = ti;
    ti1 = ti;
    ti2 = ti;
    ti3 = ti;
    ti4 = ti;
    
    rd = 1.3;       % Displacmentd from origen scaling factor.
    
    r0 = 1   * rd;
    r1 = 2   * rd;
    r2 = 3   * rd;
    r3 = 4   * rd;
    r4 = 1.5 * rd;
    
    % Key frame controls.
    
    fps = 20;    
    kf0 = fps * 10; % Lo to Hi 
    kf1 = fps * 20; % Hi to Shaded
    kf2 = fps * 30; 
    kf3 = fps * 40; % Shaded to Hi
    kf4 = fps * 50; % Hi to Shaded
    kf5 = fps * 60; 
    
    % Animate figure.
    
    frame     = 1;
    isovalue  = 0.5;    % DEfault = 0.5
    loopDelay = 0.05;     
    loop      = true;
    
    while loop == true    
    
        % Update location.
        
        f0x = r0   * sin (  2*t0 );
        f0y = r0/2 * cos (  t0/2 );
        f0z = r0/3 * cos ( -t0 );
        
        f1x =           r1   * sin ( -t1 );
        f1y =           r1/2 * cos (  2*t1 );
        f1z = ( f3x + r1/2 ) * sin (  t1/3 );
        
        f2x = r2   * sin (  t2 );
        f2y = r2/3 * cos (  t2/2 * 4 );
        f2z = r2   * cos (  t2/3 );
        
        f3x = ( f0x + r3 )   * sin (  t3 );
        f3y = ( f2y + r3/2 ) * cos (  t3 );
        f3z =           r3/3 * cos ( -t3 * 4 );
        
        f4x =  r4*2 * cos ( -t4 );
        f4y = -r4   * sin ( t4/2 );
        f4z =  r4/2 * cos ( t4*2 );
        
        t0 = t0 + ti0;
        t1 = t1 + ti1;
        t2 = t2 + ti2;
        t3 = t3 + ti3;
        t4 = t4 + ti4;
        
        % Initialize 3D mesh.

        if ( frame < kf0 )
            i = 2;
        end
        if ( ( frame >= kf0 ) && ( frame < kf1 ) )
            i = 1;
        end
        if ( ( frame >= kf1 ) && ( frame < kf3 ) )
            i = 0.75;
        end
        if ( ( frame >= kf3 ) && ( frame < kf4 ) )
            i = 1;
        end
        if ( frame > kf4 )
            i = 0.75;
        end
    
        xi = i;
        yi = i;
        zi = i;
        
        [ x, y, z ] = meshgrid ( xMin:xi:xMax, yMin:yi:yMax, zMin:zi:zMax );

        % Evaluate functions.   

        v = 1.25;    % Default = 1.0

        f0 = Gaussian3D ( x, y, z, f0x, f0y, f0z, v );
        f1 = Gaussian3D ( x, y, z, f1x, f1y, f1z, v );
        f2 = Gaussian3D ( x, y, z, f2x, f2y, f2z, v );
        f3 = Gaussian3D ( x, y, z, f3x, f3y, f3z, v );
        f4 = Gaussian3D ( x, y, z, f4x, f4y, f4z, v );

        f = f0 + f1 + f2 + f3 + f4;

        % plot function    

        p = patch ( isosurface ( x, y, z, f, isovalue ) );
        
        if ( frame < kf0 )            
            set ( p, 'FaceColor', 'none', 'EdgeColor', [ 1.0 1.0 1.0 ] )            
            hidden on;
            camlight;
            lighting none;
            view ( 0, 0 );
            grid on;
            axis on;
        end
        if ( ( frame >= kf0 ) && ( frame < kf1 ) )
            set ( p, 'FaceColor', 'none', 'EdgeColor', [ 1.0 1.0 1.0 ] )            
            hidden on;
            camlight;
            lighting none;
            view ( 0, 0 );
            grid on;
            axis on;
        end
        if ( ( frame >= kf1 ) && ( frame < kf2 ) )
            set ( p, 'FaceColor', [ 0.0 0.0 1.0 ], 'EdgeColor', 'none' )
            hidden on;
            camlight;
            lighting phong;
            view ( 0, 0 );
            grid on;
            axis on;
        end
        if ( ( frame >= kf2 ) && ( frame < kf3 ) )
            set ( p, 'FaceColor', [ 0.0 0.0 1.0 ], 'EdgeColor', 'none' )
            hidden on;
            camlight;
            lighting phong;
            view ( 45, 45/2 );
            grid on;
            axis on;
        end
        if ( ( frame >= kf3 ) && ( frame < kf4 ) )           
            set ( p, 'FaceColor', 'none', 'EdgeColor', [ 1.0 1.0 1.0 ] )  
            hidden on
            camlight;
            lighting none;
            view ( 45, 45/2 );
            grid on;
            axis on;
        end        
        if ( ( frame >= kf4 ) && ( frame < kf5 ) )  
            set ( p, 'FaceColor', [ 1.0 0.0 0.0 ], 'EdgeColor', 'none' )  
            hidden on;
            camlight;
            lighting phong;
            view ( 45, 45/2 );
            grid on;
            axis on;
        end
        if ( frame >= kf5 )
            set ( p, 'FaceColor', [ 1.0 0.0 0.0 ], 'EdgeColor', 'none' )  
            hidden on;
            camlight;
            lighting phong;
            view ( 45, 45/2 );
            grid on;
            axis off;
        end
        
        % Plot Axis
        
        axis equal;
        axis( [ xMin, xMax, yMin, yMax, zMin, zMax ] );         
        gridColor = [ 0.0 0.75 0.0 ];
        set ( gca, 'Color', 'k', 'XColor', gridColor, 'YColor', gridColor, 'ZColor', gridColor );
        set ( gcf, 'color', 'black' );
        
        
        % Record movie.
        
        Movie ( frame ) = getframe;
        frame = frame + 1;
        
        % Delay.
        
        pause ( loopDelay );
        clf;
        
        % Shut down loop if the figure is closed.
        
        if ( get ( gcf, 'CurrentCharacter' ) ) == 27
            loop = false;
        end
    end
    
    % Replay movie.
        
    set ( gcf, 'currentch', char ( 1 ) );
    while ( ( get ( gcf, 'CurrentCharacter' )  )~= 27 ) pause ( loopDelay ); end
    
    clf;
    grid off;
    axis off;
    movie ( Movie );    
        
    % clean up and exit.
    
    set ( gcf, 'currentch', char ( 1 ) );
    while ( ( get ( gcf, 'CurrentCharacter' )  )~= 27 ) pause ( loopDelay ); end
    
    close ( gcf );    
end





function Gaussian3DTest01 ()

    % Initialize application.
    
    clc;
    ConsoleMessage ( 'System', 'Initialized.' );
    ConsoleMessage ( 'System', 'Press any key to continue.' );
    waitforbuttonpress;
    ConsoleMessage ( 'System', 'Symulation executing.' );
    ConsoleMessage ( 'System', 'Press [ESC] to terminate symulation.' );
    
    % Initialize figure/s.
    
    set ( gcf, 'Position', [ 200, 200, 1048, 800 ] );
    
    % Configure 3D mesh resolution.
    
    range            = 6;
    unitResolution   = 8;
    resolutionFactor = 2/unitResolution;
    
    % Configure 3D mesh constraints.
    
    xRange = -range : resolutionFactor : range;
    yRange = -range : resolutionFactor : range;
    zRange = -range : resolutionFactor : range;
    
    % Initialize translation vecotrs.
    
    i  = pi/1024;    
    Ti = [i,i,i];
    T  = [0,0,0];    
    
    % Initialize particle parameters.
    
    N           = 8;      % Particle count.
    wireFrame   = false;
    obliqueView = false;
    
    % Configure Video recoring parameters.
    
    writerObj = VideoWriter ( 'particleSwarm02.avi' );
    writerObj.FrameRate = 60;
    open ( writerObj );
    
    % Configure loop parameters.
    
    loop      = true;
    loopDelay = 0.25;   
    
    while loop == true

        % Plot Axis.   

        axis on;
        axis equal;
        axis( [ min(xRange), max(xRange), min(yRange), max(yRange), min(zRange), max(zRange) ] );

        % Plot grid

        grid on;    
        gridColor = [ 0.0 0.5 0.0 ];
        set ( gcf, 'color', 'black' );
        set ( gca, 'Color', 'k', 'XColor', gridColor, 'YColor', gridColor, 'ZColor', gridColor );        
        set ( gca, 'GridLineStyle', '-' );    
        set ( gca, 'TickLength',  [ 0 0 ] );    
        %set ( gca, 'Projection',  'perspective' );
        set ( gca, 'Projection',  'orthographic' );
        
        % Dump data
        
        precision     = 3;
        xlabelData   = num2str ( T(1), precision  );
        xlabelString = strcat ( '\pi =', {' '} );
        xlabelString = strcat ( xlabelString, xlabelData );
        xlabel ( xlabelString );

        % Set view point.

        if  obliqueView            
            view ( 45, 45/2 );
        else            
            view ( 0, 0 );
        end

        % Draw Figure.

        % Generate mesh.

        [ x, y, z ] = meshgrid ( xRange, yRange, zRange );
        
        % Set isosurface parameters.

        v        = 1.0;     % Default = 1.0
        isovalue = 0.5;     % Default = 0.5

        f = 0;
        for n = 1:N
            
            % Calculate rotation.
            %
            % ParameterRotate ( T, O, A, P, F );
            %
            % T = Angle.
            % O = Origon vector (Location vector).
            % A = Ampletude vector.
            % P = Period vector.
            % F = Frequency vector.
        
            D = ParameterRotate ( T + n*pi/256, [0,0,0], [4*sin(n*T),4*cos(n*T),4], [ -n*pi/2, n*pi/5, n*pi/7 ], [n*pi/3,n*pi/5,n*pi/2] );
            
            % Evaluate functions.   
            
            f = f + Gaussian3D ( x, y, z, D(1), D(2), D(3), v );            
        end
        T = T + Ti/8;
        

        % Plot function.

        p = patch ( isosurface ( x, y, z, f, isovalue ) );            
        
        if wireFrame            
            set ( p, 'FaceColor', 'none', 'EdgeColor', [ 1.0 1.0 1.0 ] );
            lighting none;
        else
            set ( p, 'FaceColor', [ 0.0 0.0 1.0 ], 'EdgeColor', 'none' );
            camlight;
            lighting phong;            
        end
        hidden on;
        
        % Record movie.
        
        frame = getframe;
        writeVideo ( writerObj, frame ); 
        
        % Loop delay.
        
        pause ( loopDelay );
        clf;
        
        % Shut down loop if the figure is closed.
        
        if ( get ( gcf, 'CurrentCharacter' ) ) == 27
            loop = false;
        end
        
    end
    
    close(writerObj);
    ConsoleMessage ( 'System', 'Pre-Render playback.' );
       
    % Close down application.
    
    ConsoleMessage ( 'System', 'Press any key to exit.' );
    waitforbuttonpress;
    ConsoleMessage ( 'Function', 'Close ( gcf );' ); 
    ConsoleMessage ( '', '' ); 
    close ( gcf ); 
end





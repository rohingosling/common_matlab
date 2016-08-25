
function AnimateFigure ()
    
    % Initialize command console.
    
    clc;    

    % Calculate function.
    
    r  = 1;
    xd = 0;
    yd = 0;
    
    % Aniumaton parameters.
    
    a0 = 0;
    a1 = 2*pi;
    
    % Animate figure.
    
    margin     = 0.5;    
    frameCount = 120;
    frame      = 0;    
    loopDelay  = 0.05;    
    loop       = true;
    
    while loop == true
        
        % Update.
        
        a = a0 + frame * a1 / frameCount; 
        
        [ x, y ] = Circle ( xd, yd, r, a );
        
        % Draw figure.
        
        plot ( x, y, 'LineWidth', 1, 'Color', 'black', 'LineStyle', '-' );
        axis equal;
        axis ( [ -r-margin, r+margin, -r-margin, r+margin ] );
        
        % Next frame.
        
        frame = frame + 1;
        
        % Delay.
        
        pause ( loopDelay );
        
        % Shut down loop if the figure is closed.
        
        if ( get ( gcf, 'CurrentCharacter' ) ) == 27
            loop = false;
        end
    end
    
    close ( gcf );
        
end
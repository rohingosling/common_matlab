
classdef StaticUtility
    
    %---------------------------------------------------------------------------------------------------------------------------
    % PROPERTIES
    %---------------------------------------------------------------------------------------------------------------------------
    
    properties ( Constant )
        
        % Constants.
        
        TRUE                             = 1;
        FALSE                            = 0;        
        NEW_LINE_TRUE                    = 1;
        NEW_LINE_FALSE                   = 0;        
        CONSOLE_LEVEL_0                  = 0;
        CONSOLE_LEVEL_1                  = 1;
        CONSOLE_LEVEL_2                  = 2;
        CONSOLE_LEVEL_3                  = 3;        
        CONSOLE_TEXT_PREFIX_SYSTEM       = 'SYSTEM';
        CONSOLE_TEXT_PREFIX_ERROR        = 'ERROR';
        CONSOLE_TEXT_PREFIX_WARNING      = 'WARNING';
        CONSOLE_TEXT_DELIMINATOR_PREFIX  = ':';
        CONSOLE_TEXT_DELIMINATOR_LEVEL_0 = ' ';
        CONSOLE_TEXT_DELIMINATOR_LEVEL_1 = ' - ';
        CONSOLE_TEXT_DELIMINATOR_LEVEL_2 = ' - - ';
        CONSOLE_TEXT_DELIMINATOR_LEVEL_3 = ' - - - ';
    end
    
    %---------------------------------------------------------------------------------------------------------------------------
    % STATIC METHODS
    %---------------------------------------------------------------------------------------------------------------------------
    
    methods ( Static )
        
        %-----------------------------------------------------------------------------------------------------------------------
        % CONSOLE_event
        %-----------------------------------------------------------------------------------------------------------------------
                
        function console_message( level, new_line, console_text )

            % Initialize string terminator.
            
            if new_line == StaticUtility.NEW_LINE_TRUE
                string_terminator = '\n';
            else
                string_terminator = '';
            end
            
            % Compile message prefix.
            
            string_prefix = horzcat                             ...
            (                                                   ...
                StaticUtility.CONSOLE_TEXT_PREFIX_SYSTEM,       ...
                StaticUtility.CONSOLE_TEXT_DELIMINATOR_PREFIX   ...
            );
            
            % Initialize message level
            
            switch level
                
                case StaticUtility.CONSOLE_LEVEL_0
                    string_level = StaticUtility.CONSOLE_TEXT_DELIMINATOR_LEVEL_0;
                    
                case StaticUtility.CONSOLE_LEVEL_1
                    string_level = StaticUtility.CONSOLE_TEXT_DELIMINATOR_LEVEL_1;
                    
                case StaticUtility.CONSOLE_LEVEL_2
                    string_level = StaticUtility.CONSOLE_TEXT_DELIMINATOR_LEVEL_2;
                    
                case StaticUtility.CONSOLE_LEVEL_3
                    string_level = StaticUtility.CONSOLE_TEXT_DELIMINATOR_LEVEL_3;
                    
            end
            
            % Compile and display message string.
            
            string_message = horzcat ( string_prefix, string_level, console_text, string_terminator );
            fprintf ( string_message );    

        end
        
        %-----------------------------------------------------------------------------------------------------------------------
        % initialize_console
        %-----------------------------------------------------------------------------------------------------------------------
        
        function initialize_console ()            
            
            % Clear workspaces.
            
            clear global;                           % Clear Function workspace.
            evalin ( 'base', 'clear global' );      % Clear base work space. 
            
            % Clear the console and set numeric format.
            
            clc;            
            format long;
        end
        
        %-----------------------------------------------------------------------------------------------------------------------
        % Play a tone, at frequency f hz, for period s ms.
        %-----------------------------------------------------------------------------------------------------------------------
        
        function play_tone ( frequency, period, volume )            
            
            % Configure audio properties.
            
            bit_depth   = 24;
            seconds     = period / 1000;
            sample_rate = 8192;
            sample      = 1 / sample_rate;
            
            % Initialize time series.
            
            t = 0 : sample : seconds;
            
            % Compute wave form.
            
            f         = frequency;            
            a         = volume;
            wave_form = a*sin ( 2*pi*f*t );            
                        
            % Play sound.
        
            sound ( wave_form, sample_rate, bit_depth );            
            
        end
        
        %-----------------------------------------------------------------------------------------------------------------------
        % Play a tone, at frequency f hz, for period s ms.
        %-----------------------------------------------------------------------------------------------------------------------
        
        function play_delay_tone ( frequency, period, volume, tone_delay, tone_count )            
            
            % Configure audio properties.
            
            bit_depth   = 24;
            seconds     = period / 1000;
            sample_rate = 8192;
            sample      = 1 / sample_rate;
            
            t = 0 : sample : seconds;
            
            f         = frequency;
            a         = volume;
            wave_form = a*sin ( 2*pi*f*t );

            for i = 1 : tone_count
                sound ( wave_form, sample_rate, bit_depth );
                StaticUtility.delay ( tone_delay );
            end
        end
        
        %-----------------------------------------------------------------------------------------------------------------------
        % Pause execution for t miliseconds.
        %-----------------------------------------------------------------------------------------------------------------------
        
        function delay ( t )
            t = t/1000;
            
            tic;
            while toc < t
            end
        end
    end
    
end



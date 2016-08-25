function Console    
    
    consoleState      = 0;
    AIPromptPadding   = blanks ( 1 );
    UserPromptPadding = blanks ( 1 );
    userCommand       = '';    
    
    % Display console title message.
    
    %disp ( ' ' );
    %disp ( 'Proto Console (version 0.1)' );
    disp ( ' ' );
    
    while consoleState == 0

        % User Input.

        userPrompt      = datestr ( now, '[HH:MM:SS]' );
        userPrompt      = strcat  ( userPrompt, ' User:' );
        userPrompt      = [ userPrompt UserPromptPadding ];
        userInputString = input ( userPrompt, 's' );
        disp ( ' ' );
        
        % Parse user input.
        
        if ~strcmp ( userInputString, '' )
            tokenList   = regexp ( userInputString, '(\w+)', 'tokens' );
            userCommand = tokenList{1};            
        end
        
        % Process user command.
        
        if strcmp ( userCommand, 'exit' )
            consoleState = 1;
        end
        
        % AI Reponse
        
        if consoleState == 0           

            AIPrompt   = datestr ( now, '[HH:MM:SS]' );
            AIPrompt   = strcat  ( AIPrompt, '   AI:' );            
            AIResponse = ['You said, "' userInputString '"'];
            disp ( [ AIPrompt AIPromptPadding AIResponse ] );            
            disp ( ' ' );
        end        
        
    end
    
end


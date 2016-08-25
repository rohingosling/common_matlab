function ConsoleMessage ( category, message )

    if ( strcmp ( category, '') )    
        fprintf ( '\n' ); 
    end

    if ( strcmp ( category, 'System') )    
        fprintf ( '  %s: %s\n',category,message); 
    end
    
    if ( strcmp ( category, 'Function') )    
        fprintf ( '%s: %s\n',category,message); 
    end

end

function [ input, output ] = addTrainingData ( input, output, a, b )

    % Get new sample data.

    newInputRow  = [ a, b ];
    newOutputRow = [ a+b ];

    % Add data rows to sample data matricies.

    input  = vertcat ( input,  newInputRow  );
    output = vertcat ( output, newOutputRow );
        
end


% GenerateTrainingtData

function [ inputData, outputData ] = GenerateInputData ( inputData, outputData, n )
    
    aMax       = 10;
    bMax       = 10;

    for t = 1:n

        a  = randi ( aMax, 1 );
        b  = randi ( bMax, 1 );
        si = randi ( 4, 1 );                

        inputData  = [ inputData; [ si, a, b ] ];

        switch si

            case 1 % + 
                f = a + b;
                outputData = [ outputData; f ];

            case 2 % - 
                f = a - b;
                outputData = [ outputData; f ];

            case 3 % * 
                f = a * b;
                outputData = [ outputData; f ];

            case 4 % / 
                f = a / b;
                outputData = [ outputData; f ];

            otherwise
                outputData = [ outputData; 0 ];
        end
    end

end


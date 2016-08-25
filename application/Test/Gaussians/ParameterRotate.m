% T = Angle.
% O = Origon vector (Location vector).
% A = Ampletude vector.
% P = Period vector.
% F = Frequency vector.

function Xr = ParameterRotate( T, O, A, P, F )

    i = 1; Xr(i) = O(i) + A(i) * sin ( P(i) +  F(i) * T(i) );
    i = 2; Xr(i) = O(i) + A(i) * cos ( P(i) +  F(i) * T(i) );
    i = 3; Xr(i) = O(i) + A(i) * cos ( P(i) +  F(i) * T(i) );

end


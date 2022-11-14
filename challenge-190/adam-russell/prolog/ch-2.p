alphabet(1, 'A').
alphabet(2, 'B').
alphabet(3, 'C').
alphabet(4, 'D').
alphabet(5, 'E').
alphabet(6, 'F').
alphabet(7, 'G').
alphabet(8, 'H').
alphabet(9, 'I').
alphabet(10,'J').
alphabet(11, 'K').
alphabet(12, 'L').
alphabet(13, 'M').
alphabet(14, 'N').
alphabet(15, 'O').
alphabet(16, 'P').
alphabet(17, 'Q').
alphabet(18, 'R').
alphabet(19, 'S').
alphabet(20, 'T').
alphabet(21, 'U').
alphabet(22, 'V').
alphabet(23, 'W').
alphabet(24, 'X').
alphabet(25, 'Y').
alphabet(26, 'Z').

digits([1, 2]).

sum(Digits):-
    sum([], Digits, 0).

sum(Digits, Digits, _LENGTH_). 

sum(Partial, Digits, Sum):-   
    Sum < _LENGTH_, 
    digits(L),
    member(X,L),
    S is Sum + X,
    sum([X | Partial], Digits, S). 
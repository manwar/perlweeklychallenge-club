:-initialization(main).

middle_three(N, Middle3):-
    number_chars(N, Chars),
    N > 0,
    length(Chars, Length),  
    Length > 2,
    IsOdd is Length mod 2, IsOdd == 1,
    length(M3, 3),
    PrefixLength is ceiling(Length / 2) - 2,
    length(Prefix, PrefixLength),
    append(Prefix, Middle, Chars),
    append(M3, _, Middle),
    number_chars(Middle3, M3). 

middle_three(N, Middle3):-
    (N < 0, N0 is abs(N), middle_three(N0, Middle3));
    (number_chars(N, Chars), length(Chars, Length), Length < 3, format("too short~n", _));  
    (number_chars(N, Chars), length(Chars, Length), IsOdd is Length mod 2, IsOdd == 0, format("even number of digits~n", _));
    middle_three(N, Middle3). 
    
main:-
    middle_three(1234567, Middle3),
    ((nonvar(Middle3), format("~d~n", [Middle3]), halt);
    halt).
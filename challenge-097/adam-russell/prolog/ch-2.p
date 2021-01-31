:-initialization(main).

substrings(BinaryString, N, SubStrings):-
    substrings(BinaryString, N, [], SubStrings).
substrings([], _, SubStrings, SubStrings).    
substrings(BinaryString, N, SubStringAccum, SubStrings):-
    length(L, N),
    append(L, X, BinaryString),
    substrings(X, N, [L|SubStringAccum], SubStrings).

count_flips(B, [H|T], Flips):-
    count_flips(B, [H|T], 0, Flips).
count_flips(_, [], Flips, Flips).    
count_flips(B, [H|T], FlipsSum, Flips):-
    number_codes(B0, B),
    number_codes(H0, H),
    X is xor(B0, H0),
    Flips0 is X + FlipsSum,
    count_flips(B, T, Flips0, Flips).
    
min_flips(SubStrings, MinFlips):-
    min_flips(SubStrings, [], Flips),
    sort(Flips,[MinFlips|_]).
min_flips([_], Flips, Flips).    
min_flips([H|T], FlipsAccum, Flips):-
    count_flips(H, T, Flips0),
    min_flips(T, [Flips0|FlipsAccum], Flips).

main:-
    substrings("101100101", 3, SubStrings),
    min_flips(SubStrings, Flips),
    write(Flips),nl,
    halt.

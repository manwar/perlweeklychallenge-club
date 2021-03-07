:-initialization(main).

hcs(0, String, String).
hcs(1, StringAccum, String):-
    hcs(0, [35|StringAccum], String). 
hcs(N, StringAccum, String):-
    number_codes(N, C),
    append(C, "#", Accum), 
    length(Accum, L),
    N0 is N - L, 
    append(Accum, StringAccum, StringAccum0), 
    hcs(N0, StringAccum0, String). 

hash_counting_string(N, String):-
    hcs(N, [], S),
    atom_codes(String, S).

main:-
    hash_counting_string(1, String1), 
    write(String1), nl,
    hash_counting_string(2, String2), 
    write(String2), nl, 
    hash_counting_string(3, String3), 
    write(String3), nl, 
    hash_counting_string(10, String10), 
    write(String10), nl, 
    hash_counting_string(14, String14), 
    write(String14), nl,
    halt.

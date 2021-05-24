:-initialization(main).

contains([], _, []).  
contains([H|T], Digit, [N|R]):-
    number_chars(H, C), 
    number_chars(Digit, [D]),
    member(D, C),
    N = H,
    contains(T, Digit, R).    
contains([H|T], Digit, Contains):-
    number_chars(H, C), 
    number_chars(Digit, [D]),
    \+ member(D, C),
    contains(T, Digit, Contains).    

represented(N, D):-
    findall(X, between(1, N, X), Numbers),
    contains(Numbers, D, Contains),
    sum_list(Contains, N). 

main:-
    (((represented(25, 7), write(1)); write(0)), nl),     
    (((represented(24, 7), write(1)); write(0)), nl),
    halt.    

:-initialization(main).

left_truncatable(X):-
    fd_labeling(X),
    number_codes(X, C),
    \+ member(48, C),
    length(C, L),
    findall(Truncatable, (
        between(1, L, N),
        length(T, N),
        append(_, T, C),
        number_codes(Truncatable, T),
        fd_prime(Truncatable)), Truncatables),
     length(Truncatables, NumberTruncatable),   
     L == NumberTruncatable.  

first_twenty_left_truncatable(FirstTwenty):-
    length(FirstTwenty, 20),
    fd_domain(FirstTwenty, 1, 200),
    fd_all_different(FirstTwenty),
    maplist(left_truncatable, FirstTwenty), 
    fd_labeling(FirstTwenty). 

main:-
    first_twenty_left_truncatable(FirstTwenty),
    write(FirstTwenty), nl,
    halt.
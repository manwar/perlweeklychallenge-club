:-initialization(main).

needle_haystack([H|T], N, Index):-
    ((N < H, Index is 0); 
       (last(T, Last), N > Last, 
       length([H|T], Length), Index is Length)).
needle_haystack([H|T], N, Index):-
    needle_haystack([H|T], N, 0, Index).
needle_haystack([], _, Index, Index).    
needle_haystack([_|[]], _, Index, Index).
needle_haystack([H0, _|_], N, Counter, Index):-
    H0 == N,
    Index is Counter.
needle_haystack([_, H1|_], N, Counter, Index):-
    H1 == N,
    Index is Counter + 1.
needle_haystack([H0, H1|T], N, Counter, Index):-
    H0 \== N,
    H1 \== N,
    \+ between(H0, H1, N),
    C is Counter + 2,
    needle_haystack(T, N, C, Index).
needle_haystack([H0, H1|_], N, Counter, Index):-
    H0 \== N,
    H1 \== N,
    between(H0, H1, N),
    Index is Counter + 1.
            
main:-
    needle_haystack([1, 2, 3, 4], 3, Index0),
    write(Index0), nl,
    needle_haystack([1, 3, 5, 7], 6, Index1),
    write(Index1), nl,
    needle_haystack([12, 14, 16, 18], 10, Index2),
    write(Index2), nl,
    needle_haystack([11, 13, 15, 17], 19, Index3),
    write(Index3), nl,
    halt.
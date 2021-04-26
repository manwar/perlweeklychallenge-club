/*
 Write a script to generate first 20 Chowla Numbers.
 C(n) = sum of divisors of n except 1 and n
*/

:-initialization(main).

print_with_comma([H|[]]):-
    write(H), nl.
print_with_comma([H|T]):-
    write(H),
    write(', '),
    print_with_comma(T).

factor(N, Factors):-
    S is round(sqrt(N)),
    fd_domain(X, 2, S),
    R #= N rem X,
    R #= 0,
    Q #= N // X,
    Q #\= X,
    fd_labeling([Q, X]),
    Factors = [Q, X].
factor(N, Factors):-
    S is round(sqrt(N)),
    fd_domain(X, 2, S),
    R #= N rem X,
    R #= 0,
    Q #= N // X,
    Q #= X,
    fd_labeling([Q]),
    Factors = [Q].    

chowla(ChowlaNumber):-
    between(1, 20, N),
    findall(F, factor(N, F), Fs), 
    flatten(Fs, Factors),
    sum_list(Factors, ChowlaNumber).

main:-
    findall(ChowlaNumber, chowla(ChowlaNumber), ChowlaNumbers),
    print_with_comma(ChowlaNumbers).
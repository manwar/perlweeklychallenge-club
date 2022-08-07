all_odd([]).
all_odd([H|T]):-
    number_chars(Digit, [H]),
    M is mod(Digit, 2),
    M == 1,
    all_odd(T).

reversible(X):-
    number_chars(X, XChars),
    reverse(XChars, XCharsReversed),
    number_chars(R, XCharsReversed),
    Sum is X + R, 
    number_chars(Sum, SumChars),
    all_odd(SumChars).

reversible_under_n(N, Reversible):-
    between(1, N, X),
    reversible(X),
    Reversible = X.
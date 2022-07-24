disariums(_) --> [].
disariums(Seen) --> [X], {disarium(X), \+ member(X, Seen)}, disariums([X|Seen]).

sum_power(Digits, Sum):-
    sum_power(Digits, 0, 0, Sum).
sum_power([], _, Sum, Sum).
sum_power([H|T], I, PartialSum, Sum):-   
    succ(I, N),
    number_chars(X, [H]),
    Partial is PartialSum + round(X ** N),
    sum_power(T, N, Partial, Sum).

disarium(X):-
    current_prolog_flag(max_integer, MAX_INTEGER),
    between(0, MAX_INTEGER, X),
    number_chars(X, Chars),
    sum_power(Chars, Sum),
    Sum == X.

n_disariums(N, Disariums):-
    length(Disariums, N), 
    phrase(disariums([]), Disariums). 
skip_sum(Numbers, N, Sum):-
    append(Left, [N|_], Numbers),
    sum_list(Left, SumLeft),
    Sum is N + SumLeft.

skip_summations(Numbers, Summations):-
    skip_summations(Numbers, [Numbers], Summations).
skip_summations([], Summations, Summations).
skip_summations([_|T], SummationsAccum, Summations):-
    maplist(skip_sum(T), T, Sums),
    skip_summations(Sums, [Sums|SummationsAccum], Summations).

print_summation(S):-
    write(S),
    write(' ').
print_summations([]).
print_summations([H|T]):-
    print_summations(T),
    maplist(print_summation, H), nl.

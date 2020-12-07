range_list(0, [0]).
range_list(N, List):-
    range_list(N, [], List).
range_list(0, List, List).
range_list(N, ListAccum, List):-
    N0 is N - 1,
    range_list(N0, [N|ListAccum], List).

unique_pairs(List, Pairs):-
    unique_pairs(List, List, [], Pairs).

unique_pairs([], [], Pairs, Pairs).
unique_pairs([_|T0], [], PairsAccum, Pairs):-
   unique_pairs(T0, T0, PairsAccum, Pairs).
unique_pairs([H0|T0], [H1|T1], PairsAccum, Pairs):-
   \+ member([H0, H1], PairsAccum),
   \+ member([H1, H0], PairsAccum),
   H0 \= H1,
   unique_pairs([H0|T0], T1, [[H0, H1]|PairsAccum], Pairs).
unique_pairs([H0|T0], [_|T1], PairsAccum, Pairs):-
   unique_pairs([H0|T0], T1, PairsAccum, Pairs).

write_gcd_pairs(Pairs):-
    write_gcd_pairs(Pairs, 0).
write_gcd_pairs([[I,J]|[]], Sum):-
    Sum0 is Sum + gcd(I, J),
    format("gcd(~d, ~d) = ~d ~n", [I, J, Sum0]).
write_gcd_pairs([[I,J]|T], Sum):-
    format("gcd(~d, ~d) + ", [I, J]),
    Sum0 is Sum + gcd(I, J),
    write_gcd_pairs(T, Sum0).

main:-
    range_list(4, L),
    unique_pairs(L, Pairs),
    write_gcd_pairs(Pairs),
    halt.
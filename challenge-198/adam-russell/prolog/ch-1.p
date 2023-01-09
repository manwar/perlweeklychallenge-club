largest_gap(Numbers, LargestGap):-
    largest_gap(Numbers, -1, LargestGap).  
largest_gap([], LargestGap, LargestGap).  
largest_gap([_|[]], LargestGap, LargestGap).  
largest_gap([A, B|Numbers], Gap, LargestGap):-
    G is B - A,
    (G > Gap, largest_gap([B|Numbers], G, LargestGap));
    largest_gap([B|Numbers], Gap, LargestGap).

gap_pairs(Numbers, GapPairs):-
    length(Numbers, L),
    L =< 2,
    GapPairs = 0.
gap_pairs(Numbers, GapPairs):-
    length(Numbers, L),
    L > 2, 
    largest_gap(Numbers, LargestGap),
    gap_pairs(Numbers, LargestGap, 0, GapPairs).
gap_pairs([], _, GapPairs, GapPairs).
gap_pairs([_|[]], _, GapPairs, GapPairs).
gap_pairs([A, B|Numbers], LargestGap, Pairs, GapPairs):-
    LargestGap #= B - A,
    succ(Pairs, P),
    gap_pairs([B|Numbers], LargestGap, P, GapPairs).
gap_pairs([A, B|Numbers], LargestGap, Pairs, GapPairs):-
    LargestGap #\= B - A,
    gap_pairs([B|Numbers], LargestGap, Pairs, GapPairs).

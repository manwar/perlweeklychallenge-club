reverse_pair(X, Y, Z):-
    (X =\= Y, X > Y + Y, Z = 1, !); Z = 0.
reverse_pairs([], 0).    
reverse_pairs([H|T], ReversePairs):-
    reverse_pairs(T, R),
    maplist(reverse_pair(H), T, RP),
    sum_list(RP, Sum),
    ReversePairs is R + Sum.    
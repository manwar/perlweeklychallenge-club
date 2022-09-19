trimmer(X, Y, Z):-
    X < Y,
    Z = Y.
trimmer(X, Y, Z):-
    X >= Y,
    Z = 'trimmed'.
    
trim_list(Numbers, I, TrimmedList):-
    maplist(trimmer(I), Numbers, PartialTrimmedList),
    delete(PartialTrimmedList, 'trimmed', TrimmedList).

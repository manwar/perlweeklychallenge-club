missing(L, E, Member):-
    (member(E, L), Member = nil);
    (\+ member(E, L), Member = E).
missing_members([List1, List2], [Missing1, Missing2]):-
    maplist(missing(List2), List1, Missing1Nil),
    delete(Missing1Nil, nil, Missing1),
    maplist(missing(List1), List2, Missing2Nil),
    delete(Missing2Nil, nil, Missing2).
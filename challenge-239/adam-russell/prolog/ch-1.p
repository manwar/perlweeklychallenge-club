concatenate_all([], '').
concatenate_all([H|T], Concatenated):-
    concatenate_all(T, C),
    atom_concat(H, C, Concatenated).
    
same_string(L0, L1):-
    concatenate_all(L0, C0),
    concatenate_all(L1, C1),
    C0 == C1.    
task(Str, Output) :-
        atom_string(Atom, Str),
        aggregate_all(count, (
                between(0, 9, N),
                once(maplist([Color_Atom]>>(atom_concat(Color_Atom, N, Unified_Atom), sub_atom(Atom, _, _, _, Unified_Atom)), ['R', 'G', 'B']))
        ), Result).

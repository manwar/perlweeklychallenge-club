insert_value(Current, [FB, SB], [FA, SA]) :-
        (Current > FB ->
                FA = Current,
                SA = FB
        ; Current < FB, Current > SB ->
                FA = FB,
                SA = Current
        ;
                FA = FB,
                SA = SB
        ).

task(Str, Output) :-
        string_chars(Str, Chars),
        foldall(insert_value(Current), (member(Char, Chars), atom_number(Char, Current)), [-1, -1], [_, Output]).

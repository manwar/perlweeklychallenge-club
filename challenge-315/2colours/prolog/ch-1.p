task1(List, Char, Output) :-
    findall(Index, (
        nth0(Index, List, Value),
        once(sub_string(Value, _, _, _, Char))
    ), Output).

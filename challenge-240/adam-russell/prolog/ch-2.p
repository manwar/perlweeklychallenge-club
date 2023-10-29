build_list(_, [], []).
build_list(Old, [OldH|OldT], [NewH|NewT]):-
    succ(OldH, I),
    nth(I, Old, NewH),
    build_list(Old, OldT, NewT).
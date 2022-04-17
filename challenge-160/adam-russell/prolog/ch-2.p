equilibrium_index(Numbers, I):-
    member(N, Numbers),
    append(Left, [N|Right], Numbers),
    sum_list(Left, SumLeft),
    sum_list(Right, SumRight),
    SumLeft == SumRight,
    nth(I, Numbers, N).

main:-
    (equilibrium_index([1, 3, 5, 7, 9], I), format("~d~n", [I]); format("-1~n", _)),
    (equilibrium_index([1, 2, 3, 4, 5], J), format("~d~n", [J]); format("-1~n", _)),
    (equilibrium_index([2, 4, 2], K), format("~d~n", [K]); format("-1~n", _)), halt. 
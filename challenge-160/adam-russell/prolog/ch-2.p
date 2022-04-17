equilibrium_index(Numbers, I):-
    member(N, Numbers),
    append(Left, [N|Right], Numbers),
    sum_list(Left, SumLeft),
    sum_list(Right, SumRight),
    SumLeft == SumRight,
    nth(I, Numbers, N).
peaks(L) --> peaks(L, 0).
peaks([], _) --> [].
peaks([Value], Previous) --> ({ Value > Previous } -> [Value] ; []).
peaks([Middle, Right|Rest], Left) --> ({ Left < Middle, Right < Middle} -> [Middle], peaks(Rest, Right) ; peaks([Right|Res, Middle)).

task(N, Array, Peak) :-
        findall(X, between(1, 50, X), Pick_From),
        length(Array, N),
        foldl(random_select, Array, Pick_From, _),
        phrase(peaks(Array), Peak).

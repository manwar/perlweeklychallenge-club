:-initialization(main).

jort([]).
jort([H0, H1|[]]):-
    H1 >= H0.
jort([H0, H1|T]):-
    H1 >= H0,
    jort([H1|T]).

main:-
    (jort([1, 2, 3, 4, 5]), format("1~n", _); format("0~n", _)),
    (jort([1, 3, 2, 4, 5]), format("1~n", _); format("0~n", _)),
    (jort([1, 2, 3, 4, 5, 6]), format("1~n", _); format("0~n", _)),
    halt.
  
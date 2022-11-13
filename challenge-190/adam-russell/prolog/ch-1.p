all_small([]).
all_small([H|T]):-
    H >= 97,
    H =< 122,   
    all_small(T).
    
all_capitals([]).
all_capitals([H|T]):-
    H >= 65,
    H =< 90,   
    all_capitals(T).

capital_detection([]).
capital_detection([H|T]):-
    H >= 65,
    H =< 90,
    all_capitals(T).
capital_detection([H|T]):-
    H >= 65,
    H =< 90,
    all_small(T).    
capital_detection([H|T]):-
    H >= 97,
    H =< 122,
    all_small(T).     
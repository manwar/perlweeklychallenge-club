n_pentagon_numbers(0, []).
n_pentagon_numbers(N, [H|T]):-
    H #= N * (3 * N - 1) / 2,
    Next #= N - 1,
    n_pentagon_numbers(Next, T).
    
first_pair_pentagon(FirstPair):-
    n_pentagon_numbers(10000, Pentagons),
    fd_domain([X, Y, Sum, AbsoluteDifference], Pentagons),
    Sum #= X + Y,
    Difference #= X - Y,
    ((
        Difference #< 0, 
        AbsoluteDifference #= -1 * Difference
    ); AbsoluteDifference #= Difference),
    fd_labeling([X, Y]),
    FirstPair = [X, Y].    
    
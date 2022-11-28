:-dynamic(moves/1).
moves(0).

equal_distribution(ListIntegers, _):-
    length(ListIntegers, L),
    sum_list(ListIntegers, S),
    Average is S / L,
    F is floor(Average),
    C is ceiling(Average),
    F \== C,
    fail.
equal_distribution(ListIntegers, ListEqualDistribution):-
    length(ListIntegers, L),
    sum_list(ListIntegers, S),
    Average is S / L,
    F is floor(Average),
    C is ceiling(Average),
    F == C,
    length(ListEqualDistribution, L),
    equal_distribution(ListIntegers, F, ListEqual),
    delete(ListEqual, F, ListEqualAverageDeleted),
    length(ListEqualAverageDeleted, ListEqualAverageDeletedLength),
    ((ListEqualAverageDeletedLength == 0,
      ListEqualDistribution = ListEqual);
    equal_distribution(ListEqual, ListEqualDistribution)), !.
        
distribute(Average, [X, Y], [S, T]):-
    X < Average,
    X < Y,
    S is X + 1,
    T is Y - 1,
    moves(Moves),
    succ(Moves, M),
    retract(moves(Moves)),
    asserta(moves(M)).
distribute(Average, [X, Y], [S, T]):-
    X > Average,
    X > Y,
    S is X - 1,
    T is Y + 1,
    moves(Moves),
    succ(Moves, M),
    retract(moves(Moves)),
    asserta(moves(M)).
distribute(Average, [X, Y], [S, T]):-
    ((X == Average; X == Y);
     (X < Average, X > Y)
    ),
    S = X,
    T = Y.    
    
equal_distribution([A, B|[]], Average, [X, Y|[]]):-
    maplist(distribute(Average),[[A, B]], [[X, Y]]).
equal_distribution(ListIntegers, Average, [X|T]):-
    append([A, B], RestIntegers, ListIntegers),
    maplist(distribute(Average),[[A, B]], [[X, Y]]),
    equal_distribution([Y|RestIntegers], Average, T).
    
main(ListIntegers, Moves):-
    retract(moves(_)),
    asserta(moves(0)),
    (equal_distribution(ListIntegers, _), moves(Moves), !);
    Moves = -1.
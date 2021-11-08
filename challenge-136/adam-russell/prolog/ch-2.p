fibonaccis_below_n(N, Fibonaccis):-
    fibonaccis_below_n(N, Fibonaccis, 0, [1, 1]).
fibonaccis_below_n(-1, Fibonaccis, _, Fibonaccis):- !.    
fibonaccis_below_n(N, Fibonaccis, Sum, PartialFibonaccis):-
    [H0, H1 | _] = PartialFibonaccis,
    F is H0 + H1,
    F < N,
    fibonaccis_below_n(N, Fibonaccis, Sum, [F|PartialFibonaccis]).
fibonaccis_below_n(N, Fibonaccis, Sum, PartialFibonaccis):-
    [H0, H1 | _] = PartialFibonaccis,
    F is H0 + H1,
    F > N, 
    fibonaccis_below_n(-1, Fibonaccis, Sum, PartialFibonaccis).

sum_x([], 0).
sum_x([X|Xs], X+Xse):-
    sum_x(Xs, Xse).

sum_lists(X, N, Xsub):-
    sublist(Xsub, X),
    sum_x(Xsub, Xe),
    N #= Xe.
        
fibonacci_sum_clp(N, Summands):-
    fibonaccis_below_n(N, Fibonaccis),
    sum_lists(Fibonaccis, N, Summands).

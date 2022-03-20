weird(_) --> [].
weird(Seen) --> [X], x(Seen, X), {
    findall(F, factor(X, F), Factors), flatten([1, Factors], FlatFactors),
    sum_list(FlatFactors, FactorSum), 
    FactorSum > X, 
    powerset(FlatFactors, FactorSets),
    maplist(sum_list, FactorSets, FactorSetSums),
    \+ member(X, FactorSetSums)
    }, 
    weird([X|Seen]).
x(Seen, X) --> {between(1, 1000, X), \+ member(X, Seen)}. 

powerset(X,Y):- bagof(S, subseq(S,X), Y).
subseq([], []).
subseq([], [_|_]).
subseq([X|Xs], [X|Ys] ):- subseq(Xs, Ys).
subseq([X|Xs], [_|Ys] ):- append(_, [X|Zs], Ys), subseq(Xs, Zs).

factor(N, Factors):-
    S is round(sqrt(N)),
    fd_domain(X, 2, S),
    R #= N rem X,
    R #= 0,
    Q #= N // X,
    Q #\= X,
    fd_labeling([Q, X]),
    Factors = [Q, X].
factor(N, Factors):-
    S is round(sqrt(N)),
    fd_domain(X, 2, S),
    R #= N rem X,
    R #= 0,
    Q #= N // X,
    Q #= X,
    fd_labeling([Q]),
    Factors = [Q].   
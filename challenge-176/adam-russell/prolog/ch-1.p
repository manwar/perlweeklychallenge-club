permuted(X, Y):-
    number_chars(X, XChars),
    number_chars(Y, YChars),
    msort(XChars, XCharsSorted),
    msort(YChars, YCharsSorted),
    XCharsSorted == YCharsSorted.

permuted_multiple(Permuted):-
    current_prolog_flag(max_integer, MAX_INTEGER),
    between(1, MAX_INTEGER, X),
    X2 is 2 * X,
    X3 is 3 * X,
    X4 is 4 * X,
    X5 is 5 * X,
    X6 is 6 * X,
    permuted(X, X2), permuted(X2, X3), 
    permuted(X3, X4), permuted(X4, X5), permuted(X5, X6),
    Permuted = X.


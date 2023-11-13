flip(B, F):-
    F is \ B /\ 1.
flip_matrix([], []).    
flip_matrix([Row|Matrix], [RowFlipped|MatrixFlipped]):-
    reverse(Row, RowReversed),
    maplist(flip, RowReversed, RowFlipped),
    flip_matrix(Matrix, MatrixFlipped).
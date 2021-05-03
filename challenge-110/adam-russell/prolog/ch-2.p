/*
    Write a script to transpose the contents of a given file.
*/
:-initialization(main).

transpose(Columns, Transposed):-
    transpose(Columns, _, Transposed).
transpose([], Transposed, Transposed).
transpose([H|T], TransposedAccum, Transposed):-
    transpose_row(H, TransposedAccum, TransposedAccumNew),
    reverse(TransposedAccumNew, TransposedAccumNewReversed),
    transpose(T, TransposedAccumNewReversed, Transposed).

transpose_row(Row, TransposedAccum, RowTranspose):-
    transpose_row(Row, TransposedAccum, [], RowTranspose).
transpose_row([], [], RowTranspose, RowTranspose).
transpose_row([H|T], [HAccum|TAccum], RowTransposeAccum, RowTranspose):-
    append(HAccum, H, HAccum0),
    flatten(HAccum0, HAccum1),
    transpose_row(T, TAccum, [HAccum1 | RowTransposeAccum], RowTranspose).

main:-
    transpose([[1,2,3],[4,5,6]], Transposed),
    write(Transposed), nl.
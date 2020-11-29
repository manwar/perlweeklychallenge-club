/*
    You are given m x n matrix of positive integers.
    Write a script to print spiral matrix as a list.
*/
write_remove_top(Matrix, UpdatedMatrix):-
    nth0(0, Matrix, Top),
    atomic_list_concat(Top, ",", TopString),
    write(TopString),
    nth0(0, Matrix, _, UpdatedMatrix).

write_remove_last([], UpdatedMatrix, UpdatedMatrix).
write_remove_last([H|T], RemainderAccum, UpdatedMatrix):-
    length(H, L),
    Last is L - 1,
    nth0(Last, H, Right),
    write(Right),
    write(","),
    nth0(Last, H, _, UpdatedRow),
    write_remove_last(T, [UpdatedRow|RemainderAccum], UpdatedMatrix).

write_remove_right(Matrix, UpdatedMatrix):-
    write_remove_last(Matrix, [], UpdatedMatrix).

write_remove_first([], UpdatedMatrix, UpdatedMatrix).
write_remove_first([H|T], RemainderAccum, UpdatedMatrix):-
    nth0(0, H, Left),
    write(Left),
    write(","),
    nth0(0, H, _, UpdatedRow),
    write_remove_first(T, [UpdatedRow|RemainderAccum], UpdatedMatrix).

write_remove_left(Matrix, UpdatedMatrix):-
    write_remove_first(Matrix, [], UpdatedMatrix).

write_remove_bottom(Matrix, UpdatedMatrix):-
    length(Matrix, L),
    Last is L - 1,
    nth0(Last, Matrix, Bottom),
    reverse(Bottom, ReverseBottom),
    atomic_list_concat(ReverseBottom, ",", BottomString),
    write(BottomString),
    nth0(Last, Matrix, _, UpdatedMatrix).
    
    
spiral(Matrix):-
    spiral(Matrix, _).
spiral([], _).    
spiral(Matrix, UpdatedMatrix):-
    write_remove_top(Matrix, UpdatedMatrix),
    write(","),
    write_remove_right(UpdatedMatrix, RightRemainder),
    reverse(RightRemainder, RemainderRight),
    write_remove_bottom(RemainderRight, BottomRemainder), 
    write(","),
    write_remove_left(BottomRemainder, LeftRemainder), 
    spiral(LeftRemainder, []).
spiral(_, []):-
    write("\b").
    
main:-
    spiral([
        [ 1, 2, 3 ],
        [ 4, 5, 6 ],
        [ 7, 8, 9 ]
    ]), halt.  

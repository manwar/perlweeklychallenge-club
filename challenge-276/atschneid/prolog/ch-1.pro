:- initialization(main).

increment_count_recur( _, _, [], []).
increment_count_recur( Index, Current, [O|Os], [N|Ns] ) :-
    Index > Current, N = O, succ(Current, C1),
    increment_count_recur( Index, C1, Os, Ns ).
increment_count_recur( Index, Index, [O|Os], [N|Os] ) :-
    succ(O,N).

increment_count( Index, Old, New ) :-
    increment_count_recur( Index, 0, Old, New ).

sum_inverses( [], _, 0 ).
sum_inverses( [H|T], Counts, X ) :-
    Idx is H mod 24, InvIdx is (24 - Idx) mod 24,
    succ(Idx, Idx1), nth(Idx1, Counts, Xplus),
    increment_count(InvIdx, Counts, Counts1),
    sum_inverses( T, Counts1, X1 ),
    X is X1 + Xplus.

check_completed_days_v2( [], 0 ).
check_completed_days_v2( Days, Count ) :-
    sum_inverses(
	Days,
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	Count).

check_reciprocal_count( _, [], 0 ).
check_reciprocal_count( V, [H|T], X ) :-
    0 =:= (V + H) mod 24,
    check_reciprocal_count( V, T, X1 ),
    succ(X1, X).
check_reciprocal_count( V, [H|T], X ) :-
    0 =\= (V + H) mod 24,
    check_reciprocal_count( V, T, X ).

check_completed_days_v1( [], 0 ).
check_completed_days_v1( [H|T], X ) :-
    check_reciprocal_count( H, T, X1 ),
    check_completed_days_v1( T, X2 ),
    X is X1 + X2.

output_helper( X, X ) :-
    format( " ~p ~n", [X] ).

main :-
    Inputs = [
	[12, 12, 30, 24, 24],
	[72, 48, 24, 5],
	[12, 18, 24],
	[36, 36, 36, 1, 1, 1, 1, 1, 1, 47, 47, 47, 47]
    ],
    maplist( check_completed_days_v1, Inputs, Outputs ),
    maplist( output_helper, Outputs, _ ),
    halt.



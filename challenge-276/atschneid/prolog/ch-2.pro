:- initialization(main).

head([H|_], H).

count_top( _, [], 0 ).
count_top( V, [H|_], X ) :-
    V =\= H, X is 0, !.
count_top( H, [H|T], X ) :-
    count_top( H, T, X0 ), succ( X0, X ).

count_adjacents( _, [], [1] ).
count_adjacents( I, [I|Is], [O|Os] ) :-
    count_adjacents( I, Is, [O0|Os] ), succ( O0, O ), !.
count_adjacents( _, [I|Is], [1|Os] ) :-
    count_adjacents( I, Is, Os ).

count_adjacents( [], 0 ).
count_adjacents( [I|T], Out ) :-
    count_adjacents( I, T, Out ).

max_freq_count( [], 0 ).
max_freq_count( L, X ) :-
    msort( L, L1 ), count_adjacents( L1, L2 ),
    msort( L2, L3 ), reverse( L3, L4 ),
    head( L4, H ),
    count_top( H, L4, X0 ),
    X is X0 * H.

output_helper( X, X ) :-
    format( " ~p ~n", [X] ).

main :-
    Inputs = [
	[1, 2, 2, 4, 1, 5],
	[1, 2, 3, 4, 5]
    ],
    maplist( max_freq_count, Inputs, Outputs ),
    maplist( output_helper, Outputs, _ ),
    halt.


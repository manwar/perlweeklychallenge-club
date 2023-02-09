#!/usr/bin/env swipl
% -*- prolog -*-

:-initialization(main).

use_module(library(lists)).
use_module(library(aggregate)).

special(List, [A, B, C, D]) :-
    A < B,
    B < C,
    C < D,
    nth1(A, List, ElemA),
    nth1(B, List, ElemB),
    nth1(C, List, ElemC),
    nth1(D, List, ElemD),
    ElemA + ElemB + ElemC =:= ElemD.

combination(0, _, []).
combination(N, [X|T], [X|Comb]) :-
    N > 0,
    N1 is N - 1,
    combination(N1, T, Comb).
combination(N, [_|T], Comb) :-
    N > 0,
    combination(N, T, Comb).

indexes([], []).
indexes(List, Indexes) :-
    length(List, Len),
    numlist(1, Len, I),
    combination(4, I, ICombo),
    permutation(ICombo, Indexes).

find_special(Nums) :-
    indexes(Nums, Indexes),
    special(Nums, Indexes).

solution(Nums, Count) :-
    aggregate_all(count, find_special(Nums), Count).

main :-
    solution([1,2,3,6], Ex1),
    solution([1,1,1,3,5], Ex2),
    solution([3,3,6,4,5], Ex3),
    format('Example 1: ~w~n', [Ex1]),
    format('Example 2: ~w~n', [Ex2]),
    format('Example 3: ~w~n', [Ex3]),
    halt.

#!/usr/bin/env swipl
% -*- prolog -*-

:-initialization(main).

increasing([]).
increasing([_]).
increasing([X, Y | YS]) :-
    X =< Y,
    increasing([Y | YS]).

decreasing([]).
decreasing([_]).
decreasing([X, Y | YS]) :-
    X >= Y,
    decreasing([Y | YS]).

monotonic(List) :-
    increasing(List);
    decreasing(List).

main :-
    (monotonic([1,2,2,3]) -> writeln('Example 1: true'); writeln('Example 1: false')),
    (monotonic([1,3,2]) -> writeln('Example 2: true'); writeln('Example 2: false')),
    (monotonic([6,5,5,4]) -> writeln('Example 3: true'); writeln('Example 3: false')),
    halt.

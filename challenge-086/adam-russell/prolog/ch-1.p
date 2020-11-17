:- use_module(library(optparse)).
/*
    You are given an array of integers @N and an integer $A.
    Write a script to find find if there exists a pair of elements 
    in the array whose difference is $A.
    Print 1 if exists otherwise 0.
*/
opts_spec(
    [
        [opt(numbers), 
        default([10, 8, 12, 15, 5]),
        longflags([numbers])],

        [opt(a), 
        default(7),
        longflags([a])]
    ]).

ch_1(L, N):-
    member(A, L),
    member(B, L),
    A =\= B,
    D is A - B,
    N = D,
    writeln(1).
    
ch_1(_, _):-  
    writeln(0).
    
main:-
    opts_spec(OptsSpec),
    opt_arguments(OptsSpec, [numbers(L), a(A)], _AdditionalArguments),
    ch_1(L, A),
    halt.
:- use_module(library(optparse)).
/*
    You are given an array of real numbers greater than zero.
    Write a script to find if there exists a triplet (a,b,c) 
    such that 1 < a+b+c < 2. Print 1 if you succeed otherwise 0.
*/
opts_spec(
    [
        [opt(numbers), 
        default([1.2, 0.4, 0.1, 2.5]),
        longflags([numbers])]
    ]).

ch_1(L):-
    member(A, L),
    member(B, L),
    member(C, L),
    A =\= B,
    B =\= C,
    A =\= C,
    D is A + B + C,
    D > 1,
    D < 2,
    writeln(1).
    
ch_1(_):-  
    writeln(0).
    
main:-
    opts_spec(OptsSpec),
    opt_arguments(OptsSpec, [numbers(N)], _AdditionalArguments),
    ch_1(N),
    halt.
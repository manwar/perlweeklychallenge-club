:- use_module(library(clpfd)).
:- use_module(library(optparse)).
/*
    You are given a positive integer $N.
    Write a script to find if it can be expressed
    as a ^ b where a > 0 and b > 1. 
    Print 1 if you succeed otherwise 0.
*/
opts_spec(
    [
        [opt(number), 
        default(0),
        longflags([number])]
    ]).

/*
    Ok, I'll admit, this is a pretty silly use of clpfd when
    a simple logarithm calculation would do the job! Still clpfd 
    is more fun.
*/    
ch_2(N) :-
    N0 is N - 1,
    A in 0 .. N0,    
    B in 1 .. N0,
    N #= A ^ B,
    label([A,B]),
    writeln(1).
ch_2(_) :-
    writeln(0).
    
main:-
    opts_spec(OptsSpec),
    opt_arguments(OptsSpec, [number(N)], _AdditionalArguments),
    ch_2(N),
    halt.
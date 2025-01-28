:- use_module(library(clpfd)).

task1(Ints, Result) :- 
        length(Ints, Max_L),
        findall(Sum, (
                N in 1..Max_L,
                N mod 2 #= 1,
                indomain(N),
                length(SA, N),
                append([_Prefix, SA, _Suffix], Ints),
                sum_list(SA, Sum)
                ), Sums),
        sum_list(Sums, Result).

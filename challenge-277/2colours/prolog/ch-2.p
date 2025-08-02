:- use_module(library(clpfd)).

find_value2(List, Index, Value, Value2) :-
        Index2 #> Index,
        nth0(Index2, List, Value2),
        (Value2 - Value >= Value, !, fail ; true).

task2(Ints, Nr_Strong_Pairs) :-
        sort(Ints, Ints_Sorted),
        findall([Value, Value2],
                (nth0(Index, Ints_Sorted, Value),
                find_value2(Ints_Sorted, Index, Value, Value2)),
                Solutions),
        length(Solutions, Nr_Strong_Pairs).

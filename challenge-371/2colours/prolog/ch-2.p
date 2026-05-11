sublist([], []).
sublist([FHD|STL], [FHD|FTL]) :- sublist(STL, FTL).
sublist(S, [_|FTL]) :- sublist(S, FTL).

task(Nums, Output) :-
        findall(Index-Value, nth1(Index, Nums, Value), Enumerated),
        findall(Values, (
                sublist(SL, Enumerated), SL = [_, _|_], SL \= Enumerated,
                pairs_keys_values(SL, Indices, Values),
                sum_list(Indices, Common_Sum), sum_list(Values, Common_Sum)
                ), Output).

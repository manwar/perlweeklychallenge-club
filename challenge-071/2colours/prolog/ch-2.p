:- discontiguous task/4.

task(List, N, Output) :-
        nb_getval(algo, Algo),
        task(Algo, List, N, Output).

set_algo(Algo) :-
        nb_setval(algo, Algo).

% first solution - a bit of cheating...
task(a, List, N, Output) :-
        length(List, L),
        Index is max(0, L - N),
        nth0(Index, List, _, Output).

reverse([]) --> [].
reverse([HD|TL]) --> reverse(TL), [HD].

drop_nth1([First|Rest], N) --> ({ N = 1 ; Rest = [] } -> Rest ; [First], { N1 is N - 1 }, drop_nth1(Rest, N1)).

% second solution - using own DCGs for list handling
task(b, List, N, Output) :-
        phrase(reverse(List), List_Backwards),
        print_term(List_Backwards, []),
        phrase(drop_nth1(List_Backwards, N), Output_Backwards),
        phrase(reverse(Output_Backwards), Output).


main :-
        set_algo(b). % default selected solution

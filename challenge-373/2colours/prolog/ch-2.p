:- initialization main.
:- discontiguous task/4.

task(List, N, Output) :-
        nb_getval(algo, Algo),
        task(Algo, List, N, Output).

set_algo(Algo) :-
        nb_setval(algo, Algo).

% first solution - determining length and using append for unification
task(a, List, N, Output) :-
        length(List, L),
        (L < N ->
                Output = -1
        ;
                length(Output, N),
                divmod(L, N, Elements_Per_Chunk, Leftover),
                Elements_Per_Longer_Chunk is Elements_Per_Chunk + 1,
                length(Longer_Chunks, Leftover),
                append(Longer_Chunks, Normal_Chunks, Output),
                maplist([Chunk]>>length(Chunk, Elements_Per_Longer_Chunk), Longer_Chunks),
                maplist([Chunk]>>length(Chunk, Elements_Per_Chunk), Normal_Chunks),
                append(Output, List)
        ).

:- use_module(library(dcg/high_order)).

% second solution - parsing the parts using DCGs
n_times(N, DCG, [PHD|PTL]) --> { N > 0, N1 is N - 1 }, call(DCG, PHD), n_times(N1, DCG, PTL).
n_times(0, _, []) --> [].
item(X) --> [X].

task(b, List, N, Output) :-
        length(List, L),
        (L < N ->
                Output = -1
        ;
                divmod(L, N, Elements_Per_Chunk, Leftover),
                Elements_Per_Longer_Chunk is Elements_Per_Chunk + 1,
                phrase(n_times(Leftover, n_times(Elements_Per_Longer_Chunk, item), Longer_Chunks), List, Rest_For_Normal_Chunks),
                phrase(sequence(n_times(Elements_Per_Chunk, item), Normal_Chunks), Rest_For_Normal_Chunks),
                phrase((Longer_Chunks, Normal_Chunks), Output)
        ).

main :-
        set_algo(a). % default selected solution

/* 
* You are given a binary tree containing 
* only the numbers 0-9.
* Write a script to sum all possible paths 
* from root to leaf.
*/
:-initialization(main).
 
dfs(Node, Graph, [Node|Path]):- 
    dfs(Node, Graph, Path, []).
dfs(_, _, [], _).
dfs(Node, Graph, [AdjNode|Path], Seen) :-
    member(r(Node, Adjacent), Graph),
    member(AdjNode, Adjacent),
    \+ memberchk(AdjNode, Seen),
    dfs(AdjNode, Graph, Path, [Node|Seen]).

sum_paths(Paths, Sum):-
    sum_paths(Paths, 0, Sum).
sum_paths([], Sum, Sum).
sum_paths([H|T], PartialSum, Sum):-
    sum_list(H, ListSum),
    S is PartialSum + ListSum,
    sum_paths(T, S, Sum).

path_lengths([], _).
path_lengths([H|T], [L|Lengths]):-
    length(H, L),
    path_lengths(T, Lengths).

partial_path(_, _, []). 
partial_path(Path, MaxPathLength, [H|T]):-
    length(Path, PathLength),
    length(H, HLength),
    (PathLength < MaxPathLength ; (subtract(Path, H, Remaining), length(Remaining, 0))),
    partial_path(Path, MaxPathLength, T).
partial_path(Path, MaxPathLength, [H|_]):-
    length(Path, PathLength),
    length(H, HLength),
    PathLength =< MaxPathLength,
    subtract(Path, H, Remaining),
    \+ length(Remaining, 0),
    fail.
    
complete_paths(Paths, CompletePaths):-
    path_lengths(Paths, PathLengths),
    max_list(PathLengths, MaxPathLength),
    complete_paths(Paths, Paths, MaxPathLength, [], CompletePaths).
complete_paths([], _, _, CompletePaths, CompletePaths).    
complete_paths([H|T], Paths, MaxPathLength, CompletePathsAccum, CompletePaths):-
    \+ partial_path(H, MaxPathLength, Paths),
    complete_paths(T, Paths, MaxPathLength, [H|CompletePathsAccum], CompletePaths).   
complete_paths([H|T], Paths, MaxPathLength, CompletePathsAccum, CompletePaths):-
    partial_path(H, MaxPathLength, Paths),
    complete_paths(T, Paths, MaxPathLength, CompletePathsAccum, CompletePaths). 
    
main:-
   findall(Path0, dfs(1,[r(1,[2]),r(2,[3,4])], Path0), Paths0),
   complete_paths(Paths0, CompletePaths0),
   sum_paths(CompletePaths0, Paths0Sum),
   write(Paths0Sum), nl,
   findall(Path1, dfs(1,[r(1,[2,3]), r(3,[5,6]), r(2,[4])], Path1), Paths1),
   complete_paths(Paths1, CompletePaths1),
   sum_paths(CompletePaths1, Paths1Sum),
   write(Paths1Sum), nl, halt.
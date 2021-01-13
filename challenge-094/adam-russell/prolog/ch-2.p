/* 
* You are given a binary tree. Write a script to 
* represent the given binary tree as an object and   
* flatten it to a linked list object. 
* Finally, print the linked list object.
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

unseen_nodes(Nodes, NodeList, Unseen):-
    unseen_nodes(Nodes, NodeList, [], Unseen).
unseen_nodes([], _, Unseen, Unseen).
unseen_nodes([H|T], NodeList, UnseenAccum, Unseen):- 
    \+ memberchk(H, NodeList),
    unseen_nodes(T, NodeList, [H|UnseenAccum], Unseen).  
unseen_nodes([H|T], NodeList, UnseenAccum, Unseen):-
    memberchk(H, NodeList),
    unseen_nodes(T, NodeList, UnseenAccum, Unseen).  

paths_list(Paths, List):-
    paths_list(Paths, [], List).
paths_list([], List, List).
paths_list([H|T], ListAccum, List):-
    unseen_nodes(H, ListAccum, Unseen),
    append(ListAccum, Unseen, ListAccum0), 
    paths_list(T, ListAccum0, List).    

print_list([H|[]]):-
    format("~d~n", [H]).  
print_list([H|T]):-
    format("~d -> ", [H]),   
    print_list(T).

main:-
    findall(Path, dfs(1,[r(1,[2]),r(1,[3]),r(2,[4,5]),r(5,[6,7])], Path), Paths),
    paths_list(Paths, List),  
    print_list(List), halt.

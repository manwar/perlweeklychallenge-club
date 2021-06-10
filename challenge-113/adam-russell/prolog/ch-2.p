:-dynamic(edge/3).   

:-initialization(main).

root(1).  
edge(old, 1, 2).
edge(old, 2, 4).
edge(old, 4, 7).
edge(old, 1, 3).
edge(old, 3, 5).
edge(old, 3, 6).

dfs_replace(GraphOld, GraphNew, Vertex):-
    dfs_replace(GraphOld, GraphNew, Vertex, _).  
dfs_replace(GraphOld, GraphNew, Vertex, VertexPrevious):-
    (var(VertexPrevious), 
     edge(GraphOld, Vertex, VertexNext),
     sum_remaining(GraphOld, Vertex, SumRemaining), 
     dfs_replace(GraphOld, GraphNew, VertexNext, SumRemaining));    
    sum_remaining(GraphOld, Vertex, SumRemaining), 
    assertz(edge(GraphNew, VertexPrevious, SumRemaining)),        
    findall(V, edge(GraphOld, _, V), VerticesOld),
    findall(V, edge(GraphNew, _, V), VerticesNew),
    length(VerticesOld, VOL),  
    length(VerticesNew, VNL),  
    VOL \== VNL,  
    edge(GraphOld, Vertex, VertexNext),
    dfs_replace(GraphOld, GraphNew, VertexNext, SumRemaining).   
dfs_replace(GraphOld, GraphNew, _, _):-
    findall(V, edge(GraphOld, _, V), VerticesOld),
    findall(V, edge(GraphNew, _, V), VerticesNew),
    length(VerticesOld, VOL),  
    length(VerticesNew, VNL),  
    VOL == VNL.   

sum_remaining(GraphOld, Vertex, SumRemaining):-
    findall(V, edge(GraphOld, _, V), Vertices),
    root(Root),  
    delete([Root|Vertices], Vertex, RemainingVertices),
    sum_list(RemainingVertices, SumRemaining).  

main:-
    root(Root),  
    dfs_replace(old, new, Root),   
    listing(edge/3),
    halt.   

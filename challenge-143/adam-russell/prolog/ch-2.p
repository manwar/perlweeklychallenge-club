:-initialization(main). 
   
stealthy(N):-
    fd_domain(S, 2, N),
    fd_domain(T, 2, N),
    fd_domain(U, 2, N),
    fd_domain(V, 2, N),
    S * T #= N,
    U * V #= N,
    S + T #= U + V + 1,
    fd_labeling([S, T, U, V]).
    
main:-
    (stealthy(36), format("~d~n", [1]);format("~d~n", [0])),
    (stealthy(12), format("~d~n", [1]);format("~d~n", [0])),
    (stealthy(6), format("~d~n", [1]);format("~d~n", [0])),
    halt. 

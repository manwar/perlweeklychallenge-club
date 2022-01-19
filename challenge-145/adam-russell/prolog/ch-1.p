dot_product([], [], DotProduct):-
    DotProduct = 0.

dot_product([A|T0], [B|T1], DotProduct):-
    dot_product(T0, T1, DP),
    DotProduct is (A * B) + DP.    
    
main:-
    dot_product([1, 2, 3], [4, 5, 6], DotProduct),
    write(DotProduct), nl.
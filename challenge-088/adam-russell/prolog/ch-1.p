/*
    You are given an array of positive integers @N.
    Write a script to return an array @M where $M[i] is 
    the product of all elements of @N except the index $N[i].
*/
product_a_b(A, B, P):- 
    P is A*B.
list_product([], 1).
list_product([H|T], P) :-
        foldl(product_a_b, T, H, P).

list_products(List, Products):-
    length(List, L0),
    L is L0 - 1,
    list_products(List, L, [], Products). 
list_products(_, -1, Products, Products).       
list_products(List, Index, ProductsAccum, Products):-
    nth0(Index, List, _, Remainder),
    list_product(Remainder, Product),
    NewIndex is Index - 1,
    list_products(List, NewIndex, [Product|ProductsAccum], Products).
    
main:-
    list_products([5, 2, 1, 4, 3], Products),
    write(Products),
    halt.    
    
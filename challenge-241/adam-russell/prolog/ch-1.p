arithmetic_triplets(Numbers, Difference, TripletCount):-
    [X, Y, Z|T] = Numbers,  
    arithmetic_triplets([X, Y, Z|T], [Y, Z|T], [Z|T], Difference, TripletCount). 
arithmetic_triplets([], [], [], _, 0).  
arithmetic_triplets(I, [_|J], [], Difference, TripletCount):-
    [_|K] = J, 
    arithmetic_triplets(I, J, K, Difference, TripletCount). 
arithmetic_triplets([_|I], [], [], Difference, TripletCount):-
    [_|J] = I, 
    [_|K] = J, 
    arithmetic_triplets(I, J, K, Difference, TripletCount).  
arithmetic_triplets([IH|I], [JH|J], [KH|K], Difference, TripletCount):-
    Difference #= JH - IH,
    Difference #= KH - JH,  
    arithmetic_triplets([IH|I], [JH|J], K, Difference, TripletCountNext),  
    succ(TripletCountNext, TripletCount). 
arithmetic_triplets([IH|I], [JH|J], [KH|K], Difference, TripletCount):-
    (Difference #\= JH - IH; Difference #\= KH - JH),  
    arithmetic_triplets([IH|I], [JH|J], K, Difference, TripletCountNext),  
    TripletCount is TripletCountNext + 0. 
 

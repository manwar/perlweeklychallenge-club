arithmetic_triplets(Numbers, Difference, TripletCount):-
    [X, Y, Z|T] = Numbers,  
    arithmetic_triplets([X, Y, Z|T], [Y, Z|T], [Z|T], Difference, TripletCount). 
arithmetic_triplets([], [], [], _, 0).  
arithmetic_triplets([IX, IY, IZ|I], [JY, JZ|J], [], Difference, TripletCount):-
    arithmetic_triplets([IX, IY, IZ|I], [JZ|J], J, Difference, TripletCount). 
arithmetic_triplets([_, IY, IZ|I], [], [], Difference, TripletCount):-
    arithmetic_triplets([IY, IZ|I], [IZ|I], I, Difference, TripletCount).  
arithmetic_triplets([IX, IY, IZ|I], [JY, JZ|J], [KZ|K], Difference, TripletCount):-
    Difference #= JY - IX,
    Difference #= KZ - JY,  
    arithmetic_triplets([IX, IY, IZ|I], [JY, JZ|J], K, Difference, TripletCountNext),  
    succ(TripletCountNext, TripletCount). 
arithmetic_triplets([IX, IY, IZ|I], [JY, JZ|J], [KZ|K], Difference, TripletCount):-
    (Difference #\= JY - IX; Difference #\= KZ - JY),  
    arithmetic_triplets([IX, IY, IZ|I], [JY, JZ|J], K, Difference, TripletCountNext),  
    TripletCount is TripletCountNext + 0. 
 

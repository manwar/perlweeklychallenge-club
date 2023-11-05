arithmetic_triplets(Numbers, Difference, TripletCount):-
    [X, Y, Z|T] = Numbers,  
    arithmetic_triplets([X, Y, Z|T], [Y, Z|T], [Z|T], Difference, TripletCount). 
arithmetic_triplets([], [], [], _, 0).   
arithmetic_triplets([X, Y, Z|T], [Y, Z|T], [Z|T], Difference, TripletCount):-
    arithmetic_triplets([X, Y, Z|T], [Z|T], [T], Difference, TripletCountNext),  
    Difference #= Y - X,
    Difference #= Z - Y,  
    succ(TripletCountNext, TripletCount). 
arithmetic_triplets([X, Y, Z|T], [Y, Z|T], [Z|T], Difference, TripletCount):-
    arithmetic_triplets([X, Y, Z|T], [Z|T], [T], Difference, TripletCountNext),  
    (Difference #\= Y - X; Difference #\= Z - Y),  
    TripletCount is TripletCountNext + 0. 
arithmetic_triplets([X, Y, Z|T], [Y, Z|T], [], Difference, TripletCount):-
    arithmetic_triplets([X, Y, Z|T], [Z|T], [T], Difference, TripletCount). 
arithmetic_triplets([X, Y, Z|T], [], [], Difference, TripletCount):-
    arithmetic_triplets([Y, Z|T], [Z|T], [T], Difference, TripletCount). 
 

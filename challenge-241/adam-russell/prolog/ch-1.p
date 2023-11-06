arithmetic_triplets(Numbers, Difference, TripletCount):-
    length(Triplet, 3),  
    member(I, Triplet),      
    member(J, Triplet),      
    member(K, Triplet),      
    fd_domain(Triplet, Numbers),  
    fd_all_different(Triplet), 
    Difference #= J - I,
    Difference #= K - J,  
    I #< J,
    J #< K,
    findall(Triplet, fd_labeling(Triplet), Triplets),
    length(Triplets, TripletCount).  

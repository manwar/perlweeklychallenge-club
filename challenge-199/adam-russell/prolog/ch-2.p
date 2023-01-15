good_triplet(Numbers, X, Y, Z, Triplet):-
    length(Numbers, I),
    fd_domain(S, 1, I),
    fd_domain(T, 1, I),
    fd_domain(U, 1, I),
    S #<# T, T #<# U,   
    fd_labeling([S, T, U]),   
    fd_element(S, Numbers, Sth),  
    fd_element(T, Numbers, Tth),  
    fd_element(U, Numbers, Uth), 
    Ast is abs(Sth - Tth), Ast #=<# X,     
    Atu is abs(Tth - Uth), Atu #=<# Y,     
    Asu is abs(Sth - Uth), Asu #=<# Z, 
    Triplet = [Sth, Tth, Uth].   

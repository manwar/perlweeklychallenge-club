good_pair(Numbers, Pair):-
    length(Numbers, L),
    fd_domain(I, 1, L),
    fd_domain(J, 1, L),
    I #<# J,
    fd_labeling([I, J]), 
    fd_element(I, Numbers, Ith),  
    fd_element(J, Numbers, Jth), 
    Ith #= Jth,
    Pair = [I, J].   

magical_triple_sum(Numbers, Triple, TripleSum):-
    sublist([A, B, C], Numbers),
    A + B > C,
    B + C > A,
    A + C > B,
    Triple = [A, B, C],
    sum_list(Triple, TripleSum).
    
magical_triple(Numbers, Triple):-
    fd_maximize(magical_triple_sum(Numbers, Triple, TripleSum), TripleSum).  
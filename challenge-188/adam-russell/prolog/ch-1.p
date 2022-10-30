divisible_pair(Numbers, K, Pair):-
    length(Numbers, NumbersLength),
    between(1, NumbersLength, I),
    succ(I, INext),
    between(INext, NumbersLength, J),
    nth(I, Numbers, Ith),
    nth(J, Numbers, Jth),
    IJModK is (Ith + Jth) mod K,
    IJModK == 0,
    Pair = [I, J].
    
divisible_pairs(Numbers, K, Pairs):-
    findall(Pair, divisible_pair(Numbers, K, Pair), Pairs).    
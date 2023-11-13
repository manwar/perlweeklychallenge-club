prime_factors(N, L):- 
    N > 0,  
    prime_factors(N, L, 2).
prime_factors(1, [], _):- 
    !.
prime_factors(N, [F|L], F):-                     
    R is N // F, 
    N =:= R * F, 
    !, 
    prime_factors(R, L, F).
prime_factors(N, L, F):-
    next_factor(N, F, NF), 
    prime_factors(N, L, NF).
next_factor(_, 2, 3):- 
    !.
next_factor(N, F, NF):- 
    F * F < N, 
    !, 
    NF is F + 2.
next_factor(N, _, N).

kvf_insert_sort(List,Sorted):-
    i_sort(List,[],Sorted).

i_sort([],Acc,Acc).
i_sort([H|T],Acc,Sorted):-
    kvf_insert(H,Acc,NAcc),
    i_sort(T,NAcc,Sorted).

kvf_insert(K0-V0,[K1-V1|T],[K1-V1|NT]):-
    V0 > V1,
    kvf_insert(K0-V0,T,NT).
kvf_insert(K0-V0,[K1-V1|T],[K0-V0,K1-V1|T]):-
    V0 < V1.
kvf_insert(K0-V0,[K1-V1|T],[K1-V1|NT]):-
    V0 = V1,
    K0 > K1,
    kvf_insert(K0-V0,T,NT).
kvf_insert(K0-V0,[K1-V1|T],[K0-V0,K1-V1|T]):-
    V0 = V1,
    K0 < K1.    
kvf_insert(K0-V0, [], [K0-V0]).

write_factor_sorted([K-_|[]]):-
    write(K),
    nl.
write_factor_sorted([K-_|T]):-
    write(K),
    write(', '),
    write_factor_sorted(T).

factor_counter(Number, Number-FactorCount):-
    prime_factors(Number, Factors),
    length(Factors, FactorCount).

factor_sorter(Numbers, FactorsSorted):-
    maplist(factor_counter, Numbers, Factors),
    kvf_insert_sort(Factors, FactorsSorted).
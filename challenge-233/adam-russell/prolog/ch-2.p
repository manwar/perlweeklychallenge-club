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
    K0 < K1,
    kvf_insert(K0-V0,T,NT).
kvf_insert(K0-V0,[K1-V1|T],[K0-V0,K1-V1|T]):-
    V0 = V1,
    K0 > K1.    
kvf_insert(K0-V0, [], [K0-V0]).

frequency_writer(_-0).
frequency_writer(K-F):-
    write(K),
    write(', '),
    succ(X, F),
    frequency_writer(K-X).

write_frequencies([K-F|[]]):-
    succ(X, F),
    frequency_writer(K-X),
    write(K),
    nl.
write_frequencies([H|T]):-
    frequency_writer(H),
    write_frequencies(T).

frequency_counter(Numbers, Number, Number-Count):-
    length(Numbers, StartCount),
    delete(Numbers, Number, NumberDeleted),
    length(NumberDeleted, EndCount),
    Count is StartCount - EndCount.

frequency_sorter(Numbers, FrequencySorted):-
    sort(Numbers, UniqueNumbers),
    maplist(frequency_counter(Numbers), UniqueNumbers, Frequencies),
    kvf_insert_sort(Frequencies, FrequencySorted).
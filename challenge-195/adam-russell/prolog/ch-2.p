even(N, Even):-
    (0 is mod(N, 2), Even = N);
    (Even = nil).

frequency(ListNumbers, N, Frequency):-
    delete(ListNumbers, N, ListDeleted),
    length(ListNumbers, L),
    length(ListDeleted, LD),
    Frequency is L - LD. 

most_frequent_even(ListNumbers, MostFrequentEven):-
    maplist(even, ListNumbers, EN),
    delete(EN, nil, EvenNumbers), 
    length(EvenNumbers, LengthEvens),
    LengthEvens > 0,
    maplist(frequency(ListNumbers), EvenNumbers, Frequencies),      
    msort(Frequencies, FS), 
    reverse(FS, FrequenciesSorted), 
    ((
         nth(1, FrequenciesSorted, F1),
         nth(2, FrequenciesSorted, F2), 
         F1 \== F2,
         nth(N, Frequencies, F1),  
         nth(N, EvenNumbers, MostFrequentEven)  
     );
     (
         nth(1, FrequenciesSorted, F1),
         nth(2, FrequenciesSorted, F2), 
         F1 == F2,
         findall(MFE, (member(FX, FrequenciesSorted), FX == F1, nth(N, Frequencies, FX), nth(N, EvenNumbers, MFE)), MostFrequentEvens),   
         sort(MostFrequentEvens, MostFrequentEvensSorted), 
         nth(1, MostFrequentEvensSorted, MostFrequentEven)
     ) 
    ), !.

most_frequent_even(_, MostFrequentEven):-
    MostFrequentEven = -1, !. 

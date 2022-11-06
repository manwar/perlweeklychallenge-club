array_degree(Array, Degree):-
    array_degree(Array, Array, 0, Degree), !.
array_degree([], _, Degree, Degree).    
array_degree([H|T], Array, DegreeAccum, Degree):-
    length(Array, ArrayLength),
    delete(Array, H, ArrayWithout),    
    length(ArrayWithout,ArrayWithoutLength),
    CurrentDegree is ArrayLength - ArrayWithoutLength,
    CurrentDegree > DegreeAccum,
    array_degree(T, Array, CurrentDegree, Degree).
array_degree([H|T], Array, DegreeAccum, Degree):-
    length(Array, ArrayLength),
    delete(Array, H, ArrayWithout),    
    length(ArrayWithout,ArrayWithoutLength),
    CurrentDegree is ArrayLength - ArrayWithoutLength,
    \+ CurrentDegree > DegreeAccum,
    array_degree(T, Array, DegreeAccum, Degree).    

least_slice_degree(Array, LeastDegreeSlice):-
    array_degree(Array, ArrayDegree),
    findall(Sublist, (prefix(Prefix, Array), suffix(Suffix, Array), 
                      sublist(Sublist, Array), length(Sublist, SublistLength), 
                      SublistLength >= 2, flatten([Prefix, Sublist, Suffix], Array)), Sublists),
    sort(Sublists, Slices),                  
    findall(DegreeSlice, (member(Slice, Slices), array_degree(Slice, Degree), DegreeSlice = Degree-Slice), DegreeSlices),
    findall(MatchingSlice, (member(DegreeSlice, DegreeSlices), ArrayDegree-MatchingSlice = DegreeSlice), MatchingSlices),
    findall(LengthSlice, (member(MatchingDegreeSlice, MatchingSlices), length(MatchingDegreeSlice, MatchingDegreeSliceLength), LengthSlice = MatchingDegreeSliceLength-MatchingDegreeSlice), LengthSlices),
    keysort(LengthSlices),
    [_-LeastDegreeSlice|_] = LengthSlices.
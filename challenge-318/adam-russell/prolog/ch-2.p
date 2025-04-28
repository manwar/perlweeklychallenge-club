
  
  reverse_equals(List1, List2):-
      
  subtract(List1, List2, []),

      
      length(List1, Length),
      findall(I, (
          between(1, Length, I),
          nth(I, List1, C1),
          nth(I, List2, C2),
          \+ C1 = C2
      ), DifferenceIndices),

      
      length(DifferenceIndices, NumberDifferences),
      NumberDifferences > 0,
      nth(1, DifferenceIndices, FirstIndex),
      last(DifferenceIndices, LastIndex),
      findall(E, (
          between(FirstIndex, LastIndex, I),
          nth(I, List1, E)
      ), SubList1),
      findall(E, (
          between(FirstIndex, LastIndex, I),
          nth(I, List2, E)
      ), SubList2),  

      
      reverse(SubList1, Reverse1),
      reverse(SubList2, Reverse2),
      append(SubList1, Suffix1, S1),
      append(SubList2, Suffix2, S2),  
      append(Reverse1, Suffix1, S3),
      append(Reverse2, Suffix2, S4),     
      append(Prefix1, S1, List1),
      append(Prefix2, S2, List2),
      (append(Prefix1, S3, List2); append(Prefix2, S4, List1))
.
  reverse_equals(List1, List2):-
      
  subtract(List1, List2, []),

      
      length(List1, Length),
      findall(I, (
          between(1, Length, I),
          nth(I, List1, C1),
          nth(I, List2, C2),
          \+ C1 = C2
      ), DifferenceIndices),

      length(DifferenceIndices, NumberDifferences),
      NumberDifferences = 0.


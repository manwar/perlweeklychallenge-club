
  
  friendly(Word1, Word2):-
      subtract(Word1, Word2, []),
      length(Word1, Length),
      findall(Difference, (
          between(1, Length, I),
          nth(I, Word1, C1),
          nth(I, Word2, C2),
          \+ C1 = C2,
          Difference = [C1, C2]
      ), Differences),
      length(Differences, NumberDifferences),
      NumberDifferences == 2.


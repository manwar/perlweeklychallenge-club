
  
  find_third(Words, One, Two, Thirds):-
      length(Words, WordLength),
      N is WordLength - 2,
      findall(Third, (
          between(1, N, I),
          succ(I, J),
          nth(I, Words, One),
          nth(J, Words, Two),
          succ(J, K),
          nth(K, Words, Third)
      ), Thirds).


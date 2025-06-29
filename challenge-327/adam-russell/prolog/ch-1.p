
  
  missing_integers(L, Missing):-
      length(L, Length),
      findall(M, (
          between(1, Length, M),
          \+ member(M, L)
      ), Missing).


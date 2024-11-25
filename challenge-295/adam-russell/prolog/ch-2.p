
  
  jump_game(L):-
      jump_game(L, 1, Moves).
  jump_game(L, I, Moves):-
      length(L, Length),
      nth(I, L, X),
      between(1, X, J),
      K is I + J,
      jump_game(L, K, M),
      succ(M, Moves).
  jump_game(L, I, Moves):-
      length(L, Length),
      nth(I, L, X),
      between(1, X, J),
      K is I + J,
      K == Length, 
      Moves = 1.


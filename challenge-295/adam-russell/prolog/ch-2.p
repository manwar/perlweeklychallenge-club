
  
  jump_game(L, MinimumMoves):-
      (findall(Moves, jump_game(L, 1, Moves), AllMoves), 
       sort(AllMoves, AllMovesSorted), 
       nth(1, AllMovesSorted, MinimumMoves)); MinimumMoves = -1.
  jump_game(L, I, Moves):-
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


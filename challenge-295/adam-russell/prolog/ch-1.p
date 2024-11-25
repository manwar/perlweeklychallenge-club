
  
  word_break('', _).
  word_break(S, L):-
      member(W, L),
      atom_concat(W, R, S),
      word_break(R, L).


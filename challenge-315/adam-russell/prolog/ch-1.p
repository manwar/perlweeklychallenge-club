
  
  contains_letter(Letter, Index-Word, Index):-
      atom_chars(Word, C),
      member(Letter, C).
  contains_letter(_, _, -1).
 
  
  word_index(Words, Index):-
      word_index(Words, 0, Index).
  word_index([], _, []).
  word_index([H|T], N, [I-H|Index]):-
      succ(N, I),
      word_index(T, I, Index).

  
  find_words(Words, Letter, Indices):-
      word_index(Words, Index),
      maplist(contains_letter(Letter), Index, I),
      delete(I, -1, Indices).


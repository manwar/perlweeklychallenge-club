
  
  acronym(Words, Word):-
      maplist(nth(1), Words, FirstLetters),
      Word = FirstLetters.
 

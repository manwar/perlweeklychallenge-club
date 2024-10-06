
  
  punctuation_index(Codes, IndexPunctuation):-
      punctuation_index(Codes, 1, IndexPunctuation).
  punctuation_index([], _,  []).
  punctuation_index([Code|Codes], I, [I-P|IndexPunctuation]):-
      ((Code >= 33, Code =< 46);
       (Code >= 58, Code =< 64)),
      P = Code,
      succ(I, J),
      punctuation_index(Codes, J, IndexPunctuation).
  punctuation_index([_|Codes], I, IndexPunctuation):-
      succ(I, J),
      punctuation_index(Codes, J, IndexPunctuation).

  
  add_punctuation(Word, IndexPunctuation, PunctuatedWord):-
      add_punctuation(Word, 1, IndexPunctuation, PunctuatedWord).
  add_punctuation([], _, [], []).
  add_punctuation([Code|Codes], _, [], [Code | PunctuatedWord]):-
      add_punctuation(Codes, _, [], PunctuatedWord).
  add_punctuation([], _, [_-P|IndexPunctuation], [P | PunctuatedWord]):-
      add_punctuation([], _, IndexPunctuation, PunctuatedWord).
  add_punctuation([Code|Codes], I, [I-P|IndexPunctuation], [P, Code | PunctuatedWord]):-
      succ(I, J),
      add_punctuation(Codes, J, IndexPunctuation, PunctuatedWord).
  add_punctuation([Code|Codes], I, [X-P|IndexPunctuation], [Code | PunctuatedWord]):-
      succ(I, J),
      add_punctuation(Codes, J, [X-P|IndexPunctuation], PunctuatedWord).
   
  
  jumble_word(Word, Jumble):-
      atom_length(Word, Length),
      Length > 2,
      atom_codes(Word, Codes),
      punctuation_index(Codes, IndexPunctuation), !,
      subtract(Codes, [33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 
          45, 46, 58, 59, 60, 61, 62, 63, 64], PunctuationRemoved),
      append([First|Middle], [Last], PunctuationRemoved),
      findall(Permutation, (permutation(Middle, Permutation)), 
          Permutations),
      length(Permutations, NP),
      succ(NP, NumberPermutations),
      randomize,
      random(1, NumberPermutations, R),
      nth(R, Permutations, P),
      append([First|P], [Last], J),
      add_punctuation(J, IndexPunctuation, JP),
      atom_codes(Jumble, JP).
  jumble_word(Word, Jumble):-
      atom_length(Word, Length),
      Length =< 2,
      Jumble = Word.

  
  jumble_words(Words, Jumble):-
      maplist(jumble_word, Words, Jumble).
 


  
  vowel(97).  % a
  vowel(101). % e
  vowel(105). % i
  vowel(111). % o
  vowel(117). % u

  
  start_end_vowel(Word, StartsEnds):-
      ((nth(1, Word, FirstLetter),
        vowel(FirstLetter));
       (last(Word, LastLetter),
        vowel(LastLetter))),
      StartsEnds = true.
  start_end_vowel(_, -1).

  
  word_count(Words, Count):-
      maplist(start_end_vowel, Words, StartsEndsAll),
      delete(StartsEndsAll, -1, StartsEnds),
      length(StartsEnds, Count).


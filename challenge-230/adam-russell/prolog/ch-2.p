prefix_match(Prefix, Word, Match):-
    atom_chars(Prefix, PrefixChars),
    atom_chars(Word, WordChars),
    ((prefix(PrefixChars, WordChars), Match = 1);
     (\+ prefix(PrefixChars, WordChars), Match = 0)).

count_words(Prefix, Words, Count):-
    maplist(prefix_match(Prefix), Words, Matches),
    sum_list(Matches, Count).
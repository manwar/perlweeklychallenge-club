index_first_unique(Words, IndexUnique):-
    index_first_unique(Words, 0, IndexUnique).
index_first_unique(String, I, IndexUnique):-
    succ(I, Index),
    length(String, Length),
    nth(Index, String, Character),
    delete(String, Character, Deleted),
    length(Deleted, LengthDeleted),
    LengthDifference is Length - LengthDeleted,
    LengthDifference == 1, !, 
    IndexUnique = I.
index_first_unique(String, I, IndexUnique):-
    succ(I, Index),
    length(String, Length),
    nth(Index, String, Character),
    delete(String, Character, Deleted),
    length(Deleted, LengthDeleted),
    LengthDifference is Length - LengthDeleted,
    \+ LengthDifference == 1,
    succ(I, X),
    index_first_unique(String, X, IndexUnique).
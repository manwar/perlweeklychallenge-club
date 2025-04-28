
  
  group(Letters, Letter, Group):-
      length(Letters, LengthLetters),
      delete(Letters, Letter, Deleted),
      length(Deleted, LengthDeleted),
      Difference is LengthLetters - LengthDeleted,
      Difference >= 3,
      length(G1, Difference),
      maplist(=(Letter), G1),
      append(G1, _, G2),
      append(_, G2, Letters),
      atom_codes(Group, G1).
  group(_, _, nil).

  
  groupings(Word, Groupings):-
      sort(Word, UniqueLetters),
      maplist(group(Word), UniqueLetters, Groups),
      delete(Groups, nil, Groupings).
 

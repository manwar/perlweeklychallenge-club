
  
  remove_last(S, S1):-
      length(Last, 1),
      append(S1, Last, S). 

  
  match_length(Length, S, S):-
      length(S, Length).
  match_length(_, _, nil).

  
  all_equal([H|T]):-
      maplist(==(H), T). 

  
  all_empty(L):-
      maplist(==([]), L). 

  
  max_string_size(Strings, MaxLength):-
      maplist(length, Strings, Lengths),
      max_list(Lengths, MaxLength).

  
  equal_strings(Strings, Operations):-
      equal_strings(Strings, 0, Operations), !.
  equal_strings(Strings, Operations, Operations):-
      last(Strings, S),
      \+ S = [],
      all_equal(Strings).
  equal_strings(Strings, _, -1):-
      last(Strings, S),
      S = [].
  equal_strings(Strings, OperationsAccum, Operations):-
      max_string_size(Strings, MaxLength),
      maplist(match_length(MaxLength), Strings, S1),
      delete(S1, nil, S2),
      subtract(Strings, S2, S4),
      maplist(remove_last, S2, S3),
      append(S4, S3, S5),
      all_equal(S5), 
      \+ all_empty(S5),
      length(S2, Removals),
      Operations is OperationsAccum + Removals.
  equal_strings(Strings, OperationsAccum, Operations):-
      max_string_size(Strings, MaxLength), 
      maplist(match_length(MaxLength), Strings, S1),
      delete(S1, nil, S2),
      subtract(Strings, S2, S4),
      maplist(remove_last, S2, S3),
      append(S4, S3, S5), 
      \+ all_equal(S5), 
      length(S2, Removals), 
      O is OperationsAccum + Removals,
      equal_strings(S5, O, Operations).        
  

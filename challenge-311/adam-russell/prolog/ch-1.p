
  
  upper_lower(S, UpperLower):-
      atom_chars(S, C),
      upper_lower(C, UL, _),
      atom_chars(UpperLower, UL).
  upper_lower([], [], _).
  upper_lower([C|T], [L|UL], _):-
      lower_upper(C, C0),
      C == C0,
      lower_upper(L, C),
      upper_lower(T, UL, _).
  upper_lower([C|T], [U|UL], _):-
      lower_upper(C, U),
      \+ C == U,
      upper_lower(T, UL, _).        


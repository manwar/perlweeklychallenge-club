
  
  format_(Format), [Format] --> [Format].
  format_(F, Format), [Format] --> [F].

  
  process(String, I, J) --> {String = [Code | Codes],
                             Code == 45},
                            process(Codes, I, J).
  process(String, I, J) --> format_(F, Format),
                            {String = [Code | Codes],
                             \+ Code == 45,
                             succ(J, I),
                             char_code(C, Code),
                             length(Codes, L),
                             ((L > 0, Format = ['-', C|F]); 
                              (Format = [C|F]))},
                            process(Codes, I, 0).
  process(String, I, J) --> format_(F, Format),
                            {String = [Code | Codes],
                             \+ Code == 45,
                             succ(J, J1),
                             char_code(C, Code),
                             Format = [C|F]},
                            process(Codes, I, J1).
  process([], _, _) --> [].

  
  string_format(String, I, FormattedString):-
      reverse(String, R),
      phrase(process(R, I, 0), [[]], [F]), !,
      atom_chars(FormattedString, F).


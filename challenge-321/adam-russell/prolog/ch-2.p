
  
  characters(Characters), [Characters] --> [Characters].
  characters(C, Characters), [Characters] --> [C].

  
  process(String) --> characters(C, Characters),
                      {String = [Code | Codes],
                       last(C, PreviousCharacter),
                       ((Code \== 35, char_code(C0, Code), 
                       append(C, [C0], Characters));
                       (append(Characters, [PreviousCharacter], C))), !},
                      process(Codes).
  process([]) --> [].

  
  backspace_compare(String1, String2):-
      phrase(process(String1), [['']], [R1]),
      delete(R1, '', R2),
      atom_chars(Result1, R2),
      phrase(process(String2), [['']], [R3]),
      delete(R3, '', R4),
      atom_chars(Result2, R4),
      Result1 == Result2.



  
  replacement(Replacement), [Replacement] --> [Replacement].
  replacement(R, Replacement), [Replacement] --> [R].

  
  replace(Input) --> replacement(R, Replacement),
                     {\+ R == [],
                      Input = [C, CNext|T],
                      C == 63,
                      random(97, 123, C0),
                      last(R, CPrevious),
                      \+ C0 == CPrevious,
                      \+ C0 == CNext,
                      append(R, [C0], Replacement)
                     },
                     replace([CNext|T]).
  replace(Input) --> replacement(R, Replacement),
                     {R == [],
                      Input = [C, CNext|T],
                      C == 63,
                      random(97, 123, C0),
                      \+ C0 == CNext,
                      append(R, [C0], Replacement)
                     },
                     replace([CNext|T]).
  replace(Input) --> replacement(R, Replacement),
                     {Input = [C|T],
                      \+ C == 63,
                      append(R, [C], Replacement)
                     },
                     replace(T).                       
  replace(Input) --> replacement(R, Replacement),
                     {Input = [C|T],
                      C == 63,
                      random(97, 123, C0),
                      last(R, CPrevious),
                      \+ C0 == CPrevious,
                      append(R, [C0], Replacement)
                     },
                     replace(T).
  replace([]) --> [].

  
  replace_qs(S, Replaced):-
      phrase(replace(S), [[]], [ReplacedCodes]),
      atom_codes(Replaced, ReplacedCodes).


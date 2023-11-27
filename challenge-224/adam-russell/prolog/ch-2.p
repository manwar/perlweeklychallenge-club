additive_number(Sequence) --> Sequence, 
    { prefix(A, Sequence),
      append(A, BC, Sequence),
      prefix(B, BC),
      append(B, D, BC),
      prefix(C, D),
      append(C, T, D),
      \+ A = [],
      \+ B = [],
      \+ C = []},    
    digit_sequence(A), digit_sequence(B), digit_sequence(C), 
    { is_additive_sequence(A, B, C), 
      append(B, C, R0), 
      append(R0, T, R1), 
      T \= []}, 
    additive_number(R1).
additive_number(Sequence) --> Sequence, 
    { prefix(A, Sequence),
      append(A, BC, Sequence),
      prefix(B, BC),
      append(B, D, BC),
      prefix(C, D),
      append(C, T, D),
      \+ A = [],
      \+ B = [],
      \+ C = []},    
    digit_sequence(A), digit_sequence(B), digit_sequence(C), 
    { is_additive_sequence(A, B, C), 
      T = [], !}.
    
digit_sequence([]) --> [].    
digit_sequence([D]) --> digit(D).
digit_sequence([D|T]) --> digit(D), digit_sequence(T).

digit(D) --> [D], { between(0, 9, X), number_codes(X, [D]) }.

is_additive_sequence(A, B, C) :-
    number_codes(NA, A),
    number_codes(NB, B),
    number_codes(NC, C),
    NC is NA + NB.
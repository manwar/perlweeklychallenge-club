
  
  encoding(Encoding), [Encoding] --> [Encoding].
  encoding(E, Encoding), [Encoding] --> [E].

  
  encode(Codes) -->  
             encoding(E, Encoding),
             {Codes = [Code | T], Code >= 97, Code =< 122},
             {last(E, Count), append(L, [Count], E), 
              ((Count == nil, X = 0, C = Code); Count = C-X),
              ((Code == C, succ(X, X0), C0 = C, 
                append(L, [C0 - X0], Encoding));
                (Code =\= C, X0 = 1, C0 = Code, 
                append(E, [C0 - X0], Encoding)))},
             encode(T).
  encode([]) --> [].
  
  code(Code) --> [Code], {integer(Code), Code >= 97, Code =< 122}. 


  
  build_encoded([], '').
  build_encoded([H|T], Encoded):-
      H = C - X,
      number_atom(X, N),
      atom_codes(A, [C]),
      build_encoded(T, E),
      ((X > 1, atom_concat(N, A, NA), atom_concat(NA, E, Encoded));
       (X == 1, atom_concat(A, E, Encoded))).

  
  encoder(String, EncodedString):-
      phrase(encode(String), [[nil]], [Encoding]),
      build_encoded(Encoding, EncodedString).

  
  decoding(Decoding), [Decoding] --> [Decoding].
  decoding(D, Decoding), [Decoding] --> [D].

  
  decode(Codes) -->  decoding(D, Decoding), 
                     {phrase(letter(L), Codes, R), 
                      append(D, [L], Decoding)},
                     decode(R).
  decode(Codes) --> decoding(D, Decoding), 
                    {phrase(number_letter(NL), Codes, R),
                     append(D, [NL], Decoding)},
                    decode(R).
  decode([]) --> [].
  
  number_letter(NL) --> number(N), letter(L), {append([N], L, NL)}.
    
  number(N) --> digit(D), number(N0), {append([D], N0, N)}.
  number([]) --> [].  

  letter(L) --> [C], {C >= 97, C =< 122, L = C}.
  
  digit(D)  --> [C], {C >= 48, C =< 57, D = C}.

  
  build_decoded([], '').
  build_decoded([H|T], Decoded):-
      H = [X|C],
      number_codes(N, X),
      length(L, N), maplist(=(C), L),
      build_decoded(T, D),
      atom_codes(A, L),
      atom_concat(A, D, Decoded).
  build_decoded([H|T], Decoded):-
      number(H),
      build_decoded(T, D),
      atom_codes(A, [H]),
      atom_concat(A, D, Decoded).     

  
  decoder(String, DecodedString):-
      phrase(decode(String), [[]], [Decoding]),
      build_decoded(Decoding, DecodedString), !.
  

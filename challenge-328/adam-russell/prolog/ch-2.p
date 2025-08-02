
  
  bad_pair([], _):- false.
  bad_pair(S, P):-
      member(X, S),
      member(Y, S),
      \+ X == Y,
      nth(I, S, X),
      nth(J, S, Y),
      succ(I, J),
      (X is Y + 32; X is Y - 32), P = [I, J], !.

  
  deletion(Deletion), [Deletion] --> [Deletion].
  deletion(D, Deletion), [Deletion] --> [D].

  
  make_good(S) --> deletion(D, Deletion),
                   {D == [], \+ S == [], Deletion = S},
                   make_good(S).
  make_good(S) --> deletion(D, Deletion),
                   {\+ D == [],
                    bad_pair(S, P),
                    [I, _] = P,
                    I > 1,
                    prefix(Prefix, S),
                    length(Prefix, I0),
                    I0 is I - 1,
                    append(Prefix, [_, _|Rest], S),
                    append(Prefix, Rest, Deletion)
                   },
                   make_good(Deletion).
  make_good(S) --> deletion(D, Deletion),
                   {\+ D == [],
                    bad_pair(S, P),
                    [I, _] = P,
                    I == 1,
                    append([_, _], Deletion, S)
                   },
                   make_good(Deletion).
  make_good(S) --> deletion(_, Deletion), 
                   {\+ bad_pair(S, _),
                    Deletion = S}.
  make_good([]) --> [].

  
  make_good_string(S, Good):-
      phrase(make_good(S), [[]], [GoodCodes]),
      atom_codes(Good, GoodCodes), !.


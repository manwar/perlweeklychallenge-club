
  
  
  remove_one([], S, S).
  remove_one([H|T], L, S):-
      member(H, L),
      select(H, L, L0),
      remove_one(T, L0, S).

  matchstick_square(L):-
      sublist(S0, L),
      S0 \== [],
      remove_one(S0, L, L0),
      L0 \== [],
      sublist(S1, L0), 
      S1 \== [],
      remove_one(S1, L0, L1),
      L1 \== [],
      sublist(S2, L1),
      S2 \== [],
      remove_one(S2, L1, L2),
      L2 \== [],        
      sublist(S3, L2),
      S3 \== [],
      remove_one(S3, L2, L3),
      L3 == [],  
      sum_list(S0, Sum0),
      sum_list(S1, Sum1),
      sum_list(S2, Sum2),
      sum_list(S3, Sum3), 
      Sum0 == Sum1, Sum1 == Sum2, Sum2 == Sum3, !.


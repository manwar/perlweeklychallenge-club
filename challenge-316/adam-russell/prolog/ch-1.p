
  
  circular([]).
  circular([_]).
  circular([H0, H1|T]):-
      last(H0, C0),
      nth(1, H1, C1),
      C0 = C1,
      circular([H1|T]).
 

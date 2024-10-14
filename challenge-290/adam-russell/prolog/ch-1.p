
  
  double_exist(L, I, J):-
      length(L, Length),
      fd_domain([I, J], 1, Length),
      I #\= J,
      fd_element(I, L, X),
      fd_element(J, L, Y),
      X #= 2 * Y,
      fd_labeling([I, J]).


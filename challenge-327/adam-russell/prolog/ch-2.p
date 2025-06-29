
  
  mad(L, Pairs):-
      fd_max_integer(MAX_INT),
      fd_domain([I, J], L),
      fd_domain(D, 1, MAX_INT),
      J #> I, 
      fd_minimize((D #= J - I, fd_labeling([D])), D),
      findall(Pair, (fd_labeling([I, J]), Pair = [I, J]), Pairs).


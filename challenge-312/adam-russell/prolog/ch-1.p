
  
  compute_moves(Current, Next, Moves):-
      X is Current - 96,
      Y is Next - 96,
      XH is X + 13,
      YH is Y + 13,
      ((Y >= XH, Moves is X + 26 - Y);
       (Y >= X, Y =< XH, Moves is Y - X);
       (X >= YH, Moves is Y + 26 - X);
       (X >= Y, X =< YH, Moves is X - Y)).       

  
  minimum_time([Current, Next|Letters]) --> [Time], {
      compute_moves(Current, Next, Moves),
      succ(Moves, Time)}, minimum_time([Next|Letters]).
  minimum_time([_]) --> [].

  minimum_time(S, MinimumTime):-
      append([97], S, S0),
      phrase(minimum_time(S0), Times),
      sum_list(Times, MinimumTime), !.

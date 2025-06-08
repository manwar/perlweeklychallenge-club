
  
  create_array(_, 0, _, []).
  create_array(L, Rows, Columns, [Row|T]) :-
      create_row(L, Columns, Row, L1),  
      R is Rows - 1,                              
      create_array(L1, R, Columns, T).  

  create_row(L, 0, [], L). 
  create_row([H|T], Columns, [H|Row], L) :-
      C is Columns - 1,
      create_row(T, C, Row, L).


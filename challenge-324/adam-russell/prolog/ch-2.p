
  
  subtotal(Combined, X):-
      X is Combined.

  
  total_xor(L, Total):-
      findall(S, (
        sublist(S, L), 
        \+ S = []
      ), SubLists),
      maplist(combine, SubLists, Combined),
      maplist(subtotal, Combined, SubTotals),
      sum_list(SubTotals, Total).

  
  combine([], 0).
  combine([H|T], Combined):-
      combine(T, Combined1),
      Combined = xor(H, Combined1).



  
  next_smallest([], _, 0).
  next_smallest([H|_], Price, H):-
      H =< Price, !.
  next_smallest([H|T], Price, LowestPrice):-
      H > Price,
      next_smallest(T, Price, LowestPrice).

  
  compute_lowest([], []).
  compute_lowest([H|T], [LowestPrice|LowestPrices1]):-
      compute_lowest(T, LowestPrices1),
      next_smallest(T, H, Discount),
      LowestPrice is H - Discount.


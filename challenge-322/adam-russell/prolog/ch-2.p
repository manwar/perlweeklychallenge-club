
  
  rank(SortedList, X, Rank):-
      nth(Rank, SortedList, X).

  
  rank_list(L, Ranks):-
      sort(L, Sorted),
      maplist(rank(Sorted), L, Ranks).


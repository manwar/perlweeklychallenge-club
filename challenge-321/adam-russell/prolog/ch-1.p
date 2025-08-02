
  
  first_last([], []).
  first_last(Numbers, FirstLastPairs):-
      nth(1, Numbers, First),
      last(Numbers, Last),
      append([First|Rest], [Last], Numbers),
      first_last(Rest, FirstLastPairs0),
      append([[First, Last]], FirstLastPairs0, FirstLastPairs).

  
  distinct_average(Numbers, DistinctAverage):-
      sort(Numbers, NumbersSorted),
      first_last(NumbersSorted, MinimumMaximumPairs),
      maplist(sum_list, MinimumMaximumPairs, MinimumMaximumSums),
      sort(MinimumMaximumSums, MinimumMaximumSumsSorted),
      length(MinimumMaximumSumsSorted, DistinctAverage).


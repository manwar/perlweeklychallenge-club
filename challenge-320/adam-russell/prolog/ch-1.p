
  
  identify_negatives(Number, 1):-
      Number < 0.
  identify_negatives(_, 0).

  
  identify_positives(Number, 1):-
      Number > 0.
  identify_positives(_, 0).

  
  count_negatives(Numbers, Count):-
      maplist(identify_negatives, Numbers, Negatives),
      sum_list(Negatives, Count).

  
  count_positives(Numbers, Count):-
      maplist(identify_positives, Numbers, Positives),
      sum_list(Positives, Count).

  
  maximum_count(Numbers, MaximumCount):-
      count_negatives(Numbers, NegativesCount),
      count_positives(Numbers, PositivesCount),
      max_list([NegativesCount, PositivesCount], MaximumCount).


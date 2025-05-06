
  
  minimum_common(List1, List2, MinimumCommon):-
      
  subtract(List1, List2, Difference1),
  subtract(List2, List1, Difference2),
  append(Difference1, Difference2, Differences),
  subtract(List1, Differences, Common),

      length(Common, L),
      L >= 1,
      min_list(Common, MinimumCommon).
  minimum_common(_, _, -1).


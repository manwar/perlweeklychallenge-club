
  
  third_maximum(L, ThirdMaximum):-
      sort(L, Sorted), 
      reverse(Sorted, SortedReverse), 
      (nth(3, SortedReverse, ThirdMaximum), !; 
       last(Sorted, ThirdMaximum)).


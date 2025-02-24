
  
  gap(Gap), [Gap] --> [Gap].
  gap(G, Gap), [Gap] --> [G].

  
  min_gap([]) --> [].
  min_gap(Integers) --> {[_] = Integers}.
  min_gap(Integers) -->  
             gap(G, Gap),
             {[X,Y|T] = Integers, D is Y - X, var(G), G = D, append([], [G], Gap)},
             min_gap([Y|T]).
  min_gap(Integers) -->  
             gap(G, Gap),
             {[X,Y|T] = Integers, D is Y - X, last(G, GCurrent), D < GCurrent, append(G, [D], Gap)},
             min_gap([Y|T]).
  min_gap(Integers) --> 
             gap(G, Gap),
             {[X,Y|T] = Integers, D is Y - X, last(G, GCurrent), D >= GCurrent, Gap = G},
             min_gap([Y|T]).

  
  min_gap(Integers, MinGap):-
      msort(Integers, SortedIntegers),
      phrase(min_gap(SortedIntegers), [_], [Gaps]),
      last(Gaps, MinGap), !.
 

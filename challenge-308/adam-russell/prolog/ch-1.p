
  
  gap(Gap), [Gap] --> [Gap].
  gap(G, Gap), [Gap] --> [G].

  
  min_gap([]) --> [].
  min_gap(Integers) --> {[_] = Integers}.
  min_gap(Integers) -->  
             gap(G, Gap),
             {[X,Y|T] = Integers, D is Y - X, var(G), G = D, append([], [G-Y], Gap)},
             min_gap([Y|T]).
  min_gap(Integers) -->  
             gap(G, Gap),
             {[X,Y|T] = Integers, D is Y - X, last(G, GCurrent-_), D < GCurrent, append(G, [D-Y], Gap)},
             min_gap([Y|T]).
  min_gap(Integers) --> 
             gap(G, Gap),
             {[X,Y|T] = Integers, D is Y - X, last(G, GCurrent-_), D >= GCurrent, Gap = G},
             min_gap([Y|T]).

  
  min_gap(Integers, MinGapLocation):-
      phrase(min_gap(Integers), [_], [Gaps]),
      last(Gaps, _-MinGapLocation), !.


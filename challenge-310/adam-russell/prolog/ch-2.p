
  
  odd_even_indexed(List, Odds, Evens):-
      length(List, L),
      findall(Odd,(
          between(1, L, Index),
          succ(I, Index),
          M is I rem 2,
          \+ M == 0,
          nth(Index, List, Odd)
      ), Odds),
      findall(Even,(
          between(1, L, Index),
          succ(I, Index),
          M is I rem 2,
          M == 0,
          nth(Index, List, Even)
      ), Evens).

  
  negate(X, Y):-
      Y is -1 * X.

  
  combine(OddsSorted, EvensSorted, Combined):-
      combine(OddsSorted, EvensSorted, 0, [], Combined).
  combine([], [], _, Combined, Combined).   
  combine([O|OT], EvensSorted, Index, CombinedAccum, Combined):-
      M is Index rem 2,
      \+ M == 0,
      append(CombinedAccum, [O], C),
      succ(Index, I),
      combine(OT, EvensSorted, I, C, Combined).
  combine(OddsSorted, [E|ET], Index, CombinedAccum, Combined):-
      M is Index rem 2,
      M == 0,
      append(CombinedAccum, [E], C),
      succ(Index, I),
      combine(OddsSorted, ET, I, C, Combined).

  
  sort_odd_evens(List, Sorted):-
      odd_even_indexed(List, Odds, Evens),
      maplist(negate, Odds, OddsNegated),
      sort(OddsNegated, OddsNegatedSorted),
      maplist(negate, OddsNegatedSorted, OddsSorted),
      sort(Evens, EvensSorted),
      combine(OddsSorted, EvensSorted, Sorted).


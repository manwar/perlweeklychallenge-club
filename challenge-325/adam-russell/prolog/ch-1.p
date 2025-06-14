
  
  consecutive_ones(Consecutive), [Consecutive] --> [Consecutive].
  consecutive_ones(C, Consecutive), [Consecutive] --> [C].

  
  count_ones(Input) --> consecutive_ones(C, Consecutive),
                     {Input = [H|T],
                      H == 1, 
                      [Count, Maximum] = C,
                      succ(Count, Count1),
                      ((Count1 > Maximum, Consecutive = [Count1, Count1]);
                       (Consecutive = [Count1, Maximum]))
                      },
                      count_ones(T).
  count_ones(Input) --> consecutive_ones(C, Consecutive),
                     {Input = [H|T],
                      H == 0, 
                      [_, Maximum] = C,
                      Consecutive = [0, Maximum]},
                      count_ones(T).
  count_ones([]) --> [].

  
  consecutive_ones(L, MaximumConsecutive):-
      phrase(count_ones(L), [[0, 0]], [Output]), !,
      [_, MaximumConsecutive] = Output.


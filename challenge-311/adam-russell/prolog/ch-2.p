
  
  group_digit_sum(S, Size, GroupDigitSum):-
      group_list(S, Size, GroupedList),
      
  maplist(sum_list, GroupedList, Sums),

      
  flatten(Sums, SumsFlatted),
  join(SumsFlatted, A),
  atom_property(A, length(Length)),
  ((Length =< Size, GroupDigitSum = A, !);
   (group_digit_sum(A, Size, GroupDigitSum), !)).


  
  group_list(S, Size, GroupedList):-
      atom_chars(S, C),
      maplist(char_number, C, N),
      group_list(N, Size, [], [], GroupedList).
  group_list([], _, Group, GroupedListAccum, GroupedList):-
      length(Group, L),
      ((L > 0, append(GroupedListAccum, [Group], GroupedList));
       (GroupedList = GroupedListAccum)).
  group_list([H|T], Size, Group, GroupedListAccum, GroupedList):-
      length(Group, L),
      L < Size, 
      append(Group, [H], G), 
      GLA = GroupedListAccum,
      group_list(T, Size, G, GLA, GroupedList).
  group_list([H|T], Size, Group, GroupedListAccum, GroupedList):-
      length(Group, L),
      L == Size, 
      append(GroupedListAccum, [Group], GLA),
      group_list([H|T], Size, [], GLA, GroupedList).

  
  char_number(C, N):-
      number_chars(N, [C]).

  
  join([], '').
  join([H|T], A):-
      join(T, A0),
      number_atom(H, A1),
      atom_concat(A1, A0, A).


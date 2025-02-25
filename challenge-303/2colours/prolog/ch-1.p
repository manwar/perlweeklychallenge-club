variation(Set, Size, Variation, Set_Rest) :-
  foldl([Choice, Remaining_Before-Set_Before, Remaining_After-Set_After]>>(
    select(Choice, Set_Before, Set_After),
    plus(Remaining_After, 1, Remaining_Before)
  ), Variation, Size-Set, 0-Set_Rest).

task1(Ints, Unique_Solutions) :-
        findall(Number, (
                variation(Ints, 3, Variation, _Rest),
                [First_Digit|_] = Variation, First_Digit > 0,
                foldl([Digit, Num_Before, Num_After]>>(Num_After is Num_Before * 10 + Digit), Variation, 0, Number),
                Number mod 2 =:= 0
        ), Numbers),
        list_to_ord_set(Numbers, Unique_Solutions).

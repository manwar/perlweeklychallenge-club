missing_number(Numbers, Missing):-
    length(Numbers, NumbersLength),
    between(0, NumbersLength, Missing),
    \+ member(Missing, Numbers).
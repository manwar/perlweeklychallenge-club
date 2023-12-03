largest_of_three(Numbers, LargestOfThree):-
    findall(Number,(
        sublist(SubList, Numbers),
        \+ SubList = [],
        permutation(SubList, SubListPermutation),
        number_codes(Number, SubListPermutation),
        0 is Number mod 3), NumbersOfThree),
    ((NumbersOfThree = [], LargestOfThree = -1);
     (max_list(NumbersOfThree, LargestOfThree))). 
    
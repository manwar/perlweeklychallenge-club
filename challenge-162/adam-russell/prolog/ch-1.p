weight(-1, 1).
weight(1, 3).

check_sum([], _, 0).
check_sum([H|T], I, CheckSum):-
    N is I * -1,
    check_sum(T, N, C),
    weight(I, Weight),
    CheckSum is H * Weight + C.
isbn_check_digit(ISBN, CheckDigit):-
    check_sum(ISBN, -1, CheckSum),
    Check is mod(CheckSum, 10),
    CheckDigit is 10 - Check.

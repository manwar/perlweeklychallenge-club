code2digit(C, D):-
    number_codes(D, [C]).

special(N):-
    number_codes(N, NCodes),
    maplist(code2digit, NCodes, Digits),
    sort(Digits, DigitsSorted),
    length(Digits, NumberDigits),
    length(DigitsSorted, NumberDigits).

number_special(N, NumberSpecial):-
    findall(I, (between(1, N, I), special(I)), Specials),
    length(Specials, NumberSpecial). 

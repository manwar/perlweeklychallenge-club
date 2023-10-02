clone(X, [X]).

separate(Number, Digits):-
    number_chars(Number, Chars),
    maplist(clone, Chars, DigitChars),
    maplist(number_chars, Digits, DigitChars).
    
separate_digits(Numbers, Digits):-
    maplist(separate, Numbers, D),
    flatten(D, Digits).
acronym(Strings, CheckString):-
    maplist(nth(1), Strings, CheckStringUpperCaseCodes),
    maplist(char_code, CheckStringUpperCase, CheckStringUpperCaseCodes),
    maplist(lower_upper, CheckStringLowerCase, CheckStringUpperCase),
    atom_chars(CheckStringA, CheckStringLowerCase),
    atom_codes(CheckStringA, CheckString).
greater_than_character(Target, C0, C1):-
    C0 > Target,
    C1 = C0.   
greater_than_character(Target, C0, C1):-
    \+ C0 > Target,
    C1 = nil.  
    
greater_character(Characters, Target, Greater):-
    maplist(greater_than_character(Target), Characters, GreaterCharacters),
    delete(GreaterCharacters, nil, GreaterCharactersNonNil),
    length(GreaterCharactersNonNil, GreaterCharactersNonNilLength),
    GreaterCharactersNonNilLength > 0,
    min_list(GreaterCharactersNonNil, GreaterChar),
    char_code(Greater, GreaterChar), !.    
greater_character(Characters, [Target], Greater):-
    maplist(greater_than_character(Target), Characters, GreaterCharacters),
    delete(GreaterCharacters, nil, GreaterCharactersNonNil),
    length(GreaterCharactersNonNil, GreaterCharactersNonNilLength),
    GreaterCharactersNonNilLength == 0,
    char_code(Greater, Target), !.      
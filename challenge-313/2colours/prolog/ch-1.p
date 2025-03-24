:- use_module(library(dcg/high_order)).

repeated_char(Char-Min_Amount) --> { Min_Amount > 0, length(Mandatory, Min_Amount), maplist(=(Char), Mandatory) }, Mandatory, repeated_char(Char-0).
repeated_char(_Char-0) --> [].
repeated_char(Char-0) --> [Char], repeated_char(Char-0).

task1(Name, Typed) :-
    string_codes(Name, Name_Codes),
    string_codes(Typed, Typed_Codes),
    clumped(Name_Codes, Name_Codes_Clumped),
    phrase(sequence(repeated_char, Name_Codes_Clumped), Typed_Codes).

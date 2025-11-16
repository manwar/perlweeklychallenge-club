:- use_module(library(dcg/basics)).
:- use_module(library(dcg/high_order)).
:- use_module(library(clpfd)).

chunk(Chunk) --> { length(Chunk, 3) ; length(Chunk, 2) }, string(Chunk).

task(Str, Result) :-
        re_replace("[ -]"/g, "", Str, Str_Stripped),
        string_codes(Str_Stripped, Codes_Stripped),
        once(phrase(sequence(chunk, Chunks), Codes_Stripped)),
        phrase(sequence(chunk, `-`, Chunks), Result_Codes),
        string_codes(Result, Result_Codes).

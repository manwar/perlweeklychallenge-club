:- use_module(library(dcg/basics)).

paren_compositions_min1 --> paren_composition, paren_compositions.

paren_compositions --> paren_compositions_min1.
paren_compositions --> [].

paren_composition --> `(`, paren_compositions, `)`.

candidate_length(Str, L) :-
        string_length(Str, Str_Len),
        candidate_length(Str, Str_Len, L).

candidate_length(Str, Str_L, C_L) :-
        string_codes(Str, Str_Codes),
        phrase((string(Prefix), paren_compositions_min1), Str_Codes, Postfix),
        length(Postfix, Rem_L),
        (
                length(Prefix, Skipped_L),
                C_L is Str_L - Rem_L - Skipped_L
        ;
                candidate_length(Postfix, Rem_L, C_L)
        ).
        


task(Str, Result) :- findall(L, candidate_length(Str, L), Ls), max_list(Ls, Result).

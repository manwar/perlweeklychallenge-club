:- use_module(library(clpfd)).
:- use_module(library(dcg/basics)).
:- use_module(library(dcg/high_order)).

n_spaces(N) --> { N #> 0 }, ` `, { N - 1 #= N1 }, n_spaces(N1).
n_spaces(0) --> [].

word_then_spaces(W-SC) --> string_without(` `, W), { W = [_|_] }, n_spaces(SC).
words_spaces(Words, Space_Count) -->
        n_spaces(Leading_Spaces),
        sequence(word_then_spaces, WSC_Pairs),
        { pairs_keys_values(WSC_Pairs, Words, Space_Counts), sum_list([Leading_Spaces|Space_Counts], Space_Count) }.

task(Str, Output) :-
        string_codes(Str, Str_Codes),
        once(phrase(words_spaces(Words, Space_Count), Str_Codes)),
        length(Words, Word_Count),
        Gap_Count is Word_Count - 1,
        (Gap_Count =:= 0 ->
                Leftover_Spaces = Space_Count
        ;
                divmod(Space_Count, Gap_Count, Space_Per_Gap, Leftover_Spaces)
        ),
        phrase((sequence(string, n_spaces(Space_Per_Gap), Words), n_spaces(Leftover_Spaces)), Output_Codes),
        string_codes(Output, Output_Codes).

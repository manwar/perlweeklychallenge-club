build_assoc(Index-Char, A_Before, A_After) :-
        (get_assoc(Char, A_Before, Span_Before) ->
                Span_After = Span_Before.put(right, Index)
        ;
                Span_After = #{left: Index, right: Index}
        ),
        put_assoc(Char, A_Before, Span_After, A_After).

task(Str, Output) :-
        string_chars(Str, Chars),
        findall(Index-Value, nth1(Index, Chars, Value), Chars_Enumerated),
        empty_assoc(A_Start),
        foldl(build_assoc, Chars_Enumerated, A_Start, A_End),
        aggregate_all(max(Span_Diff), (gen_assoc(_, A_End, #{left: L, right: R}), Span_Diff is R - L - 1), Output).

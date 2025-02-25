find_spans(List, Size, Spans) :-
        length(Span, Size),
        findall(Span,
                append([_, Span, _], List),
                Spans).

task2(Ints, Result) :-
        msort(Ints, Ints_Sorted),
        find_spans(Ints_Sorted, 2, Neighbors),
        maplist([[Left, Right], Diff]>>(Diff is Right - Left), Neighbors, Diffs),
        min_list(Diffs, Result).

find_spans(List, Size, Spans) :-
        length(Span, Size),
        findall(Span,
                append([_, Span, _], List),
                Spans).

task1(Ints, Result) :-
        find_spans(Ints, 2, Neighbors),
        maplist([[Before, Follower], Follower-Gap]>>(Gap is Follower - Before), Neighbors, Pairs),
        pairs_values(Pairs, Gaps),
        min_list(Gaps, Min_Gap),
        member(Result-Min_Gap, Pairs). % explicitly chooses ALL possible minimums, could be restricted with eg. calling once(...)

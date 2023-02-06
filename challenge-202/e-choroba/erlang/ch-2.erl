-module(widest_valley).
-export([widest_valley/1]).
-record(valley, {from=1, to=1, deepest=1}).

widest_valley([]) ->
    [];
widest_valley([H]) ->
    [H];
widest_valley([H,T]) ->
    [H,T];
widest_valley(L) ->
    widest_valley(L, #valley{}, #valley{}, 1, 2).

widest_valley(L, _Curr, Widest, _FlatFrom, Pos) when Pos > length(L) ->
    lists:sublist(L, Widest#valley.from,
                  1 + Widest#valley.to - Widest#valley.from);
widest_valley(L, Curr, Widest, FlatFrom, Pos) ->
    Before  = lists:nth(Pos - 1, L),
    AtPos   = lists:nth(Pos, L),
    Deepest = lists:nth(Curr#valley.deepest, L),
    Curr1 = if Before == Deepest ->
                    Curr#valley{deepest = if AtPos < Deepest ->
                                                  Pos;
                                             true            ->
                                                  Curr#valley.deepest
                                          end};
               AtPos < Before ->
                    #valley{from=FlatFrom, deepest=Pos};
               true ->
                    Curr
            end,
    FlatFrom1 = if AtPos == Before ->
                        FlatFrom;
                   true ->
                        Pos
                end,
    Widest1 =
        if Pos - Curr1#valley.from > Widest#valley.to - Widest#valley.from
           -> Curr1#valley{to=Pos};
           true ->
                Widest
        end,
    widest_valley(L, Curr1, Widest1, FlatFrom1, Pos + 1).

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
widest_valley_test() ->
    ?assert(widest_valley([1, 5, 5, 2, 8]) == [5, 5, 2, 8]),
    ?assert(widest_valley([2, 6, 8, 5]) == [2, 6, 8]),
    ?assert(widest_valley([9, 8, 13, 13, 2, 2, 15, 17]) == [13, 13, 2, 2, 15, 17]),
    ?assert(widest_valley([2, 1, 2, 1, 3]) == [2, 1, 2]),
    ?assert(widest_valley([1, 3, 3, 2, 1, 2, 3, 3, 2]) == [3, 3, 2, 1, 2, 3, 3]).
-endif.

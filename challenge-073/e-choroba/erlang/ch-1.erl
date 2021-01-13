-module(pwc073).
-export([min_sliding_window/2, smallest_neighbour/1]).

min_sliding_window(List, WinSize) when length(List) < WinSize ->
    [];
min_sliding_window(List, WinSize) ->
    [lists:min(lists:sublist(List, WinSize))
    | min_sliding_window(lists:nthtail(1, List), WinSize)].

smallest_neighbour([H|T]) ->
    [0 | smallest_neighbour(T, H)].

smallest_neighbour([], _Min) ->
    [];
smallest_neighbour([H|T], Min) ->
    [ case Min < H of
          true -> Min;
          false -> 0
      end
    | smallest_neighbour(T, case H < Min of
                                true -> H;
                                false -> Min
                            end )
    ].

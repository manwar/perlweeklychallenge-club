-module(ch1).
-author("Ali Moradi").
-export([distinct_average/1]).

distinct_average(L) ->
  L2 = lists:sort(L),
  L3 = pair_min_max(L2),
  L4 = lists:map(fun({A, B}) -> A + B end, L3),
  sets:size(sets:from_list(L4)).

pair_min_max(L) ->
  {Left, Right} = lists:split(length(L) div 2, L),
  lists:zip(Left, lists:reverse(Right)).

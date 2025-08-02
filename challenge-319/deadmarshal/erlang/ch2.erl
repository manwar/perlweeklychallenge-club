-module(ch2).
-author("Ali Moradi").
-export([minimum_common/2]).
-include_lib("eunit/include/eunit.hrl").

-spec minimum_common([integer()], [integer()]) -> integer().
minimum_common(L1, L2) ->
  S1 = sets:from_list(L1),
  S2 = sets:from_list(L2),
  Intersection = sets:intersection(S1, S2),
  IntersectionList = sets:to_list(Intersection),
  case IntersectionList of
    [] -> -1;
    _ -> lists:min(IntersectionList)
  end.

-ifdef(TEST).
simple_test() ->
  [?assertEqual(3, ch2:minimum_common([1, 2, 3, 4], [3, 4, 5, 6])),
    ?assertEqual(2, ch2:minimum_common([1, 2, 3], [2, 4])),
    ?assertEqual(-1, ch2:minimum_common([1, 2, 3, 4], [5, 6, 7, 8]))].
-endif.

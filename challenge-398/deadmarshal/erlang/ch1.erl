-module(ch1).
-export([divisible_average/1]).
-include_lib("eunit/include/eunit.hrl").

-spec divisible_average(L) -> R when
    L :: [integer()],
    R :: integer().
divisible_average(L) ->
  F = lists:filter(fun(E) -> E rem 2 =:= 0 andalso 
			       E rem 3 =:= 0 end,L),
  N = length(F),
  case N of
    0 -> 0;
    _ -> lists:sum(F) div N
  end.

-ifdef(TEST).
divisible_average_test_() ->
  [
   {"Example 1",
    ?_assertEqual(18,divisible_average([18,5,7,11]))},
   {"Example 2",
    ?_assertEqual(18,divisible_average([6,12,18,24,30,40]))},
   {"Example 3",
    ?_assertEqual(0,divisible_average([3,9,15,21,27]))},
   {"Example 4",
    ?_assertEqual(9,divisible_average([6,12,14,20]))},
   {"Example 5",
    ?_assertEqual(8,divisible_average([6,6,6,12,12]))}
  ].
-endif.


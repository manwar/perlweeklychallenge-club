-module(ch2).
-export([reverse_degree/1]).
-include_lib("eunit/include/eunit.hrl").

-spec reverse_degree(S) -> R when
    S :: string(),
    R :: integer().
reverse_degree(S) ->
  Map = maps:from_list(lists:zip(lists:seq($a,$z),
				 lists:seq(26,1,-1))),
  Cs = string:to_lower(S),
  Zipped = lists:zip(lists:seq(1,length(Cs)),Cs),
  lists:sum([maps:get(C,Map) * Index || {Index,C} <- Zipped]).

-ifdef(TEST).
reverse_degree_test_() ->
  [
   {"Example 1",
    ?_assertEqual(1,reverse_degree("z"))},
   {"Example 2",
    ?_assertEqual(26,reverse_degree("a"))},
   {"Example 3",
    ?_assertEqual(147,reverse_degree("bbc"))},
   {"Example 4",
    ?_assertEqual(560,reverse_degree("racecar"))},
   {"Example 5",
    ?_assertEqual(14,reverse_degree("zyx"))}
  ].
-endif.


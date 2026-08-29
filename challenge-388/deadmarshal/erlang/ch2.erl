-module(ch2).
-export([derange/1]).
-include_lib("eunit/include/eunit.hrl").

derange(N) ->
  {ok,Pid} = memoize:start_link(),
  Res = memoize:memoize(Pid,fun derange_helper/1,[N]),
  memoize:stop(Pid),
  Res.

derange_helper(0) -> 1;
derange_helper(N) -> N * derange_helper(N-1) +
		       (if N rem 2 =:= 0 -> 1; true -> -1 end).

-ifdef(TEST).
derange_test_() ->
  [
   {"Example 1",
    ?_assertEqual(0,derange(1))},
   {"Example 2",
    ?_assertEqual(1,derange(2))},
   {"Example 3",
    ?_assertEqual(2,derange(3))},
   {"Example 4",
    ?_assertEqual(9,derange(4))},
   {"Example 5",
    ?_assertEqual(44,derange(5))}
  ].
-endif.


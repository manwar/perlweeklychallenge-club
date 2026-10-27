-module(ch2).
-export([binary_reflection/1]).
-include_lib("eunit/include/eunit.hrl").

binary_reflection(L) ->
  Rb = fun(E) -> 
	   list_to_integer(lists:reverse(integer_to_list(E,2)),2) 
       end,
  [E || {_,E} <- lists:sort([{Rb(E),E} || E <- L])].

-ifdef(TEST).
binary_reflection_test_() ->
  [
   {"Example 1",?_assertEqual([3,6,12],
			      binary_reflection([3,6,12]))},
   {"Example 2",?_assertEqual([1,2,4,8],
			      binary_reflection([1,2,4,8]))},
   {"Example 3",?_assertEqual([8,10,7,9],
			      binary_reflection([7,8,9,10]))},
   {"Example 4",?_assertEqual([5,9,15,17],
			      binary_reflection([5,9,15,17]))},
   {"Example 5",?_assertEqual([14,13,11,19],
			      binary_reflection([11,13,14,19]))}
  ].
-endif.


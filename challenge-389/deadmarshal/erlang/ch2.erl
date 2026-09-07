-module(ch2).
-export([zig_zag_subarray/1]).
-include_lib("eunit/include/eunit.hrl").

zig_zag_subarray([]) -> 0;
zig_zag_subarray([_]) -> 1;
zig_zag_subarray([H|T]) -> 
  {_,_,_,Max} = lists:foldl(
		  fun(X,{Prev,Up,Down,Max}) ->
		      if X > Prev ->
			  NewUp = Down + 1,
			  {X,NewUp,1,max(Max,NewUp)};
			 X < Prev ->
			  NewDown = Up + 1,
			  {X,1,NewDown,max(Max,NewDown)};
			 true -> {X,1,1,Max}
		      end
		  end,
		  {H,1,1,1},
		  T),
  Max.

-ifdef(TEST).
zig_zag_subarray_test_() ->
  [
   {"Example 1",
    ?_assertEqual(5,zig_zag_subarray([9,4,2,10,7,8,8,1,9]))},
   {"Example 2",
    ?_assertEqual(6,zig_zag_subarray([1,7,4,9,2,5]))},
   {"Example 3",
    ?_assertEqual(2,zig_zag_subarray([1,2,3,4,5]))},
   {"Example 4",
    ?_assertEqual(1,zig_zag_subarray([4,4,4]))},
   {"Example 5",
    ?_assertEqual(3,zig_zag_subarray([10,20,15,12,18]))}
  ].
-endif.


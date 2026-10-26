-module(ch1).
-export([absent_smallest_positive/1]).
-include_lib("eunit/include/eunit.hrl").

absent_smallest_positive(L) ->
  S = sets:from_list(L),
  N = length(L),
  Start = max(1,(lists:sum(L) div N)+1),
  lists:foldl(fun(_,I) ->
		  case sets:is_element(I,S) of
		    true -> I+1;
		    false -> I
		  end
	      end,
	      Start,
	      lists:seq(1,N+1)).

-ifdef(TEST).
absent_smallest_positive_test_() ->
  [
   {"Example 1",?_assertEqual(7,
			      absent_smallest_positive([1,2,4,5,6]))},
   {"Example 2",?_assertEqual(1,
			      absent_smallest_positive([-5,-2,-1,3]))},
   {"Example 3",?_assertEqual(4,
			      absent_smallest_positive([1,2,3]))},
   {"Example 4",?_assertEqual(6,
			      absent_smallest_positive([2,3,7,8]))},
   {"Example 5",?_assertEqual(4,
			      absent_smallest_positive([1,1,1,10]))}
  ].
-endif.


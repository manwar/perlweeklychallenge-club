-module(ch1).
-export([finishing_order/2]).
-include_lib("eunit/include/eunit.hrl").

-spec finishing_order(Order,Friends) -> R when
    Order :: [term()],
    Friends :: [term()],
    R :: [term()].
finishing_order(Order,Friends) ->
  Set = sets:from_list(Friends),
  [X || X <- Order,sets:is_element(X,Set)].

-ifdef(TEST).
finishing_order_test_() ->
  [
   {"Example 1",?_assertEqual([1,4,2],
			      finishing_order([3,1,4,2,5],[1,2,4]))},
   {"Example 2",?_assertEqual([5,3,1],
			      finishing_order([5,4,3,2,1],[1,3,5]))},
   {"Example 3",?_assertEqual([2,4,1,3],
			      finishing_order([2,4,1,3],[1,2,3,4]))},
   {"Example 4",?_assertEqual([3],
			      finishing_order([4,1,3,2],[3]))},
   {"Example 5",?_assertEqual([1,3,2],
			      finishing_order([1,3,2,6,5,4],
					      [1,2,3]))}
  ].
-endif.


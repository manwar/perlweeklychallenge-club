-module(ch2).
-export([arrange_box/1]).
-include_lib("eunit/include/eunit.hrl").

-spec arrange_box(Boxes) -> R when
    Boxes :: [{integer(),integer()}],
    R :: integer().
arrange_box(Boxes) ->
  Sorted = lists:sort(fun compare_boxes/2,Boxes),
  case Sorted of
    [] -> 0;
    _ -> Processed = lists:foldl(fun add_box/2,[],Sorted),
	 lists:max([Dp || {_Box,Dp} <- Processed])
  end.

-spec compare_boxes(T1,T2) -> R when
    T1 :: {integer(),integer()},
    T2 :: {integer(),integer()},
    R :: boolean().
compare_boxes({W1,H1},{W2,H2}) ->
  if W1 =:= W2 -> H1 >= H2; 
     true -> W1 =< W2
  end.

add_box({Wi,Hi} = Box,Processed) ->
  Candidates = [Dp+1 || {{Wj,Hj},Dp} <- Processed,Wj < Wi,Hj < Hi],
  DpI = case Candidates of [] -> 1; _ -> lists:max(Candidates) end,
  Processed ++ [{Box,DpI}].

-ifdef(TEST).
arrange_box_test_() ->
  [
   {"Example 1",?_assertEqual(4,
			      arrange_box([{1,3},{3,5},
					   {6,8},{2,4}]))},
   {"Example 2",?_assertEqual(3,
			      arrange_box([{4,5},{4,6},
					   {6,7},{2,3},{4,3}]))},
   {"Example 3",?_assertEqual(1,arrange_box([{5,5},{5,5},{5,5}]))},
   {"Example 4",?_assertEqual(4,
			      arrange_box([{2,100},{3,200},
					   {4,300},{5,50},{5,400}]))},
   {"Example 5",?_assertEqual(3,
			      arrange_box([{10,20},{15,10},
					   {20,30},{12,18},{16,25}]))}
  ].
-endif.


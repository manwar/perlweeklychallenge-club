-module(ch1).
-export([array_median/2]).
-include_lib("eunit/include/eunit.hrl").

-spec array_median(L1,L2) -> R when
    L1 :: [integer()],
    L2 :: [integer()],
    R :: float().
array_median(L1,L2) ->
  Combined = L1 ++ L2,
  Resorted = lists:sort(Combined),
  Len = length(Resorted),
  EvenOrOdd = {Len rem 2 =:= 1,Len rem 2 =:= 0,Len},
  case EvenOrOdd of
    {_,_,0} -> 0.0;
    {true,_,_} -> float(lists:nth(erlang:ceil(Len / 2),Resorted));
    {_,true,_} -> 
      LeftMiddle = trunc(Len/2),
      (lists:nth(LeftMiddle,Resorted) + 
	 lists:nth(LeftMiddle+1,Resorted)) / 2
  end.

-ifdef(TEST).
array_median_test_() ->
  [
   {"Example 1",?_assertEqual(3.0,array_median([2],[4]))},
   {"Example 2",?_assertEqual(7.0,array_median([1,2,3],[7,8,9,10]))},
   {"Example 3",?_assertEqual(25.0,array_median([],[10,20,30,40]))},
   {"Example 4",?_assertEqual(4.5,array_median([100],
					       [1,2,3,4,5,6,7]))},
   {"Example 5",?_assertEqual(2.0,array_median([1,2,2],[2,2,3]))}
  ].
-endif.


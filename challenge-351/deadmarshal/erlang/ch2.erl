-module(ch2).
-export([arithmetic_progression/1,main/0]).

-spec arithmetic_progression([number()]) -> boolean().
arithmetic_progression(L) -> 
  Sorted = lists:sort(L),
  case Sorted of 
    [] -> true;
    [_] -> true;
    [First,Second|Rest] ->
      D = abs(Second - First),
      arithmetic_progression(Rest,Second,D)
  end.

-spec arithmetic_progression([number()],number(),number()) -> boolean().
arithmetic_progression([],_Last,_D) -> true;
arithmetic_progression([Current|Rest],Last,D) ->
  if Current - Last =:= D ->
      arithmetic_progression(Rest,Current,D);
     true -> false
  end.

main() ->
  io:format("~p~n~p~n~p~n~p~n~p~n",
	    [arithmetic_progression([1,3,5,7,9]),
	     arithmetic_progression([9,1,7,5,3]),
	     arithmetic_progression([1,2,4,8,16]),
	     arithmetic_progression([5,-1,3,1,-3]),
	     arithmetic_progression([1.5,3,0,4.5,6])]).


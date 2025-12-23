-module(ch2).
-export([binary_prefix/1,main/0]).

-spec binary_prefix([non_neg_integer()]) -> [boolean()].
binary_prefix(L) ->
  {Res,_} = lists:foldl(fun(E,{Acc,X}) ->
			    NewX = ((X bsl 1) bor E) rem 5,
			    {[NewX =:= 0|Acc],NewX}
			end,
			{[],0},L),
  lists:reverse(Res).

main() ->
  io:format("~p~n~p~n~p~n~p~n~p~n",
	    [binary_prefix([0,1,1,0,0,1,0,1,1,1]),
	     binary_prefix([1,0,1,0,1,0]),
	     binary_prefix([0,0,1,0,1]),
	     binary_prefix([1,1,1,1,1]),
	     binary_prefix([1,0,1,1,0,1,0,0,1,1])]).


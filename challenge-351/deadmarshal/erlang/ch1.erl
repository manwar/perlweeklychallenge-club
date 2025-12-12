-module(ch1).
-export([special_average/1,main/0]).

-spec special_average([term()]) -> non_neg_integer().
special_average([_]) -> 0;
special_average(L) ->
  S = lists:sort(L),
  Sub = lists:sublist(S,2,length(L)-2),
  lists:sum(Sub) div length(Sub).

main() ->
  io:format("~p~n~p~n~p~n~p~n~p~n",
	    [special_average([8000,5000,6000,2000,3000,7000]),
	     special_average([100_000,80_000,110_000,90_000]),
	     special_average([2500,2500,2500,2500]),
	     special_average([2000]),
	     special_average([1000,2000,3000,4000,5000,6000])]).


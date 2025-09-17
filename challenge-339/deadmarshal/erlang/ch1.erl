-module(ch1).
-export([max_diff/1,main/0]).

-spec max_diff([integer()]) -> integer().
max_diff([]) -> undefined;
max_diff(L) ->
  N = length(L),
  S = lists:sort(L),
  E = lists:last(S) * lists:nth(N-1,S),
  F = hd(S) * lists:nth(2,S),
  E - F.

main() ->
  io:format("~p~n~p~n~p~n~p~n~p~n",
	    [max_diff([5,9,3,4,6]),
	     max_diff([1,-2,3,-4]),
	     max_diff([-3,-1,-2,-4]),
	     max_diff([10,2,0,5,1]),
	     max_diff([7,8,9,10,10])]).


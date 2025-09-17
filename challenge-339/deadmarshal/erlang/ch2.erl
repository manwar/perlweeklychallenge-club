-module(ch2).
-export([peak_point/1,main/0]).

scanl(F,Init,L) ->
  {Res,_} = lists:foldl(
	      fun(X,{AccList,Current}) ->
		  Next = F(Current,X),
		  {[Next|AccList],Next}
	      end,
	      {[Init],Init},L),
  lists:reverse(Res).

peak_point(L) ->
  lists:max(scanl(fun erlang:'+'/2,0,L)).

main() ->
  io:format("~p~n~p~n~p~n~p~n~p~n",
	    [peak_point([-5,1,5,-9,2]),
	     peak_point([10,10,10,-25]),
	     peak_point([3,-4,2,5,-6,1]),
	     peak_point([-1,-2,-3,-4]),
	     peak_point([-10,15,5])]).


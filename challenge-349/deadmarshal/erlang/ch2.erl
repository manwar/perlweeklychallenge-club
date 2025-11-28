-module(ch2).
-export([meeting_point/1,main/0]).

-spec meeting_point(string()) -> boolean().
meeting_point(S) ->
  {X,Y} = lists:foldl(fun($U,{X,Y}) -> {X,Y+1};
			 ($R,{X,Y}) -> {X+1,Y};
			 ($D,{X,Y}) -> {X,Y-1};
			 ($L,{X,Y}) -> {X-1,Y}
		      end,{0,0},S),
  X =:= 0 andalso Y =:= 0.

main() ->
  io:format("~p~n~p~n~p~n~p~n~p~n",
	    [meeting_point("ULD"),
	     meeting_point("ULDR"),
	     meeting_point("UUURRRDDD"),
	     meeting_point("UURRRDDLLL"),
	     meeting_point("RRUULLDDRRUU")]).


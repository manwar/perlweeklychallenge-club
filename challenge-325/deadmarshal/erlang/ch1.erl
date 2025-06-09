-module(ch1).
-export([consecutive_one/1]).

consecutive_one(L) ->
  {Count,Res} = lists:foldl(fun(1,{Count,Res}) -> {Count+1,Res};
			       (0,{Count,Res}) -> {0,max(Count,Res)}
			    end,
			    {0,0},
			    L),
  max(Count,Res).


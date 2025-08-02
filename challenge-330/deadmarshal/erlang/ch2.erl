-module(ch2).
-export([title_capital/1]).

title_capital(S) ->
  Words = string:tokens(S, " "),
  CW = lists:map(fun(W) when length(W) < 3 -> string:lowercase(W);
		    (W) -> string:titlecase(string:lowercase(W))
		 end,Words),
  lists:flatten(lists:join(" ",CW)).


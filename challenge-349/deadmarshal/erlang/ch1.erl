-module(ch1).
-export([power_string/1,main/0]).

-spec power_string(string()) -> integer().
power_string("") -> 0;
power_string([_]) -> 1;
power_string(S) -> 
  Gs = maps:groups_from_list(fun(X) -> X end,S),
  Ls = lists:map(fun length/1,maps:values(Gs)),
  lists:max(Ls).

main() ->
  io:format("~p~n~p~n~p~n~p~n~p~n",
	    [power_string("textbook"),
	     power_string("aaaaa"),
	     power_string("hoorayyy"),
	     power_string("x"),
	     power_string("aabcccddeeffffghijjk")]).


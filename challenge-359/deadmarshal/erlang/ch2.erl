-module(ch2).
-export([string_reduction/1,main/0]).

-spec string_reduction(string()) -> string().
string_reduction(S) ->
  Reduced = reduce(S,[]),
  lists:reverse(Reduced).

-spec reduce(string(),[char()]) -> string().
reduce([],Acc) ->
  Acc;
reduce([C|Rest],[]) ->
  reduce(Rest,[C]);
reduce([C|Rest],[C|AccRest]) ->
  reduce(Rest,AccRest);
reduce([C|Rest],Acc) ->
  reduce(Rest,[C|Acc]).

main() ->
  Tests = ["aabbccdd","abccba","abcdef","aabbaeaccdd","mississippi"],
    lists:foreach(
      fun(Test) ->
	  Res = string_reduction(Test),
	  io:format("~s -> ~s~n", [Test,Res])
      end,Tests).


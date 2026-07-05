-module(ch1).
-export([reverse_existence/1]).
-include_lib("eunit/include/eunit.hrl").

-spec reverse_existence(string()) -> boolean().
reverse_existence(S) ->
  Rev = lists:reverse(S),
  lists:any(fun(Sub) -> string:str(Rev,Sub) =/= 0 end,
	    [string:substr(S,I,2) || I <- lists:seq(1,length(S)-1)]).

-ifdef(TEST).
reverse_existence_test_() ->
  [
   {"Example 1",
    ?_assertEqual(true,reverse_existence("abcba"))},
   {"Example 2",
    ?_assertEqual(true,reverse_existence("racecar"))},
   {"Example 3",
    ?_assertEqual(false,reverse_existence("abcd"))},
   {"Example 4",
    ?_assertEqual(true,reverse_existence("banana"))},
   {"Example 5",
    ?_assertEqual(true,reverse_existence("hello"))}
  ].
-endif.


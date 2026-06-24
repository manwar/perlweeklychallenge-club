-module(ch1).
-export([reverse_string/1]).
-include_lib("eunit/include/eunit.hrl").

-spec reverse_string(string()) -> string().
reverse_string(S) -> lists:foldl(fun(C,Acc) -> [C|Acc] end,[],S).

-ifdef(TEST).
reverse_string_test_() ->
  [
   {"Example 1",
    ?_assertEqual("",
		  reverse_string(""))},
   {"Example 2",
    ?_assertEqual("gnirts nevig eht esrever",
		  reverse_string("reverse the given string"))},
   {"Example 3",
    ?_assertEqual("emosewA si lreP",
		  reverse_string("Perl is Awesome"))},
   {"Example 4",
    ?_assertEqual("!ateB-0.0.1v",
		  reverse_string("v1.0.0-Beta!"))},
   {"Example 5",
    ?_assertEqual("racecar",
		  reverse_string("racecar"))}].
-endif.


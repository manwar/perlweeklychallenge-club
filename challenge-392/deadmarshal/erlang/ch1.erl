-module(ch1).
-export([convert_palindrome/1]).
-include_lib("eunit/include/eunit.hrl").

-spec convert_palindrome(S) -> R when
    S :: string(),
    R :: string().
convert_palindrome(S) ->
  R = lists:reverse(S),
  N = length(S),
  hd([lists:sublist(R, I) ++ S
      || I <- lists:seq(0, N),
         lists:sublist(S, N - I) =:= lists:nthtail(I, R)]).

-ifdef(TEST).
convert_palindrome_test_() ->
  [
   {"Example 1", ?_assertEqual("sdepinnipeds",
                               convert_palindrome("pinnipeds"))},
   {"Example 2", ?_assertEqual("dcbabcd",
                               convert_palindrome("abcd"))},
   {"Example 3", ?_assertEqual("sananabananas",
                               convert_palindrome("bananas"))},
   {"Example 4", ?_assertEqual("tnedissident",
                               convert_palindrome("dissident"))},
   {"Example 5", ?_assertEqual("shcailliachs",
                               convert_palindrome("cailliachs"))}
  ].
-endif.


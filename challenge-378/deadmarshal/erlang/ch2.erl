-module(ch2).
-export([sum_of_words/3]).
-include_lib("eunit/include/eunit.hrl").

-spec f(string()) -> integer().
f(S) -> lists:foldl(fun(C,Acc) -> Acc * 10 + (C - $a) end,0,S).

-spec sum_of_words(string(),string(),string()) -> boolean().
sum_of_words(S1,S2,S3) -> 
  f(S1) + f(S2) =:= f(S3).

-ifdef(TEST).
sum_of_words_test_() ->
  [
   {"Example 1",
    ?_assertEqual(true, sum_of_words("acb","cba","cdb"))},
   {"Example 2",
    ?_assertEqual(true, sum_of_words("aab","aac","ad"))},
   {"Example 3",
    ?_assertEqual(false, sum_of_words("bc","je","jg"))},
   {"Example 4",
    ?_assertEqual(true, sum_of_words("a","aaaa","aa"))},
   {"Example 5",
    ?_assertEqual(false, sum_of_words("c","d","h"))},
   {"Example 6",
    ?_assertEqual(true, sum_of_words("gfi","hbf","bdhd"))}
  ].  
-endif.


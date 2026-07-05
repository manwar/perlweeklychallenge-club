-module(ch1).
-export([count_vowel/1]).
-include_lib("eunit/include/eunit.hrl").

-spec count_vowel(string()) -> [string()].
count_vowel(S) ->
  N = length(S),
  [string:slice(S,I-1,J-I+1) || 
    I <- lists:seq(1,N-4),
    J <- lists:seq(I+4,N),
    is_all_vowels(string:slice(S,I-1,J-I+1)),
    has_all_vowels(string:slice(S,I-1,J-I+1))].

-spec is_all_vowels(string()) -> boolean().
is_all_vowels(Sub) ->
  lists:all(fun(C) -> lists:member(C, "aeiou") end, Sub).

-spec has_all_vowels(string()) -> boolean().
has_all_vowels(Sub) ->
  lists:all(fun(V) -> lists:member(V, Sub) end, "aeiou").

-ifdef(TEST).
count_vowel_test_() ->
  [
   {"Example 1",
    ?_assertEqual(["aeiou"],count_vowel("aeiou"))},
   {"Example 2",
    ?_assertEqual(["aaeeeiioou","aaeeeiioouu",
		   "aeeeiioou","aeeeiioouu"],
		  count_vowel("aaeeeiioouu"))},
   {"Example 3",
    ?_assertEqual(["aeiou","aeiouu","aeiouua","eiouua","aeiou"],
		  count_vowel("aeiouuaxaeiou"))},
   {"Example 4",
    ?_assertEqual(["uaeio","uaeiou","aeiou"],count_vowel("uaeiou"))},
   {"Example 5",
    ?_assertEqual([],count_vowel("aeioaeioa"))}
  ].
-endif.


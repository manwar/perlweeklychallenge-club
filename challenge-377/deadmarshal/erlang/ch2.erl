-module(ch2).
-export([prefix_suffix/1]).
-include_lib("eunit/include/eunit.hrl").

-spec prefix_suffix([string()]) -> non_neg_integer().
prefix_suffix(L) ->
  N = length(L),
  Pairs = sets:from_list([{I,J} || I <- lists:seq(0,N-2),
				   J <- lists:seq(I+1,N-1),
				   is_valid(lists:nth(I+1,L),
					    lists:nth(J+1,L))]),
  sets:size(Pairs).

-spec is_valid(string(),string()) -> boolean().
is_valid(S1,S2) ->
  string:prefix(S2,S1) =/= nomatch andalso
    string:rstr(S2,S1) =:= length(S2) - length(S1) + 1.

-ifdef(TEST).
prefix_suffix_test_() ->
  [
   {"Example 1",
    ?_assertEqual(4,prefix_suffix(["a", "aba", "ababa", "aa"]))},
   {"Example 2",
    ?_assertEqual(2,prefix_suffix(["pa", "papa", "ma", "mama"]))},
   {"Example 3",
    ?_assertEqual(0,prefix_suffix(["abao", "ab"]))},
   {"Example 4",
    ?_assertEqual(1,prefix_suffix(["abab", "abab"]))},
   {"Example 5",
    ?_assertEqual(3,prefix_suffix(["ab", "abab", "ababab"]))},
   {"Example 6",
    ?_assertEqual(0,prefix_suffix(["abc", "def", "ghij"]))}
  ].
-endif.


-module(ch2).
-export([words_length_product/1]).
-include_lib("eunit/include/eunit.hrl").

-spec common_letters(S1,S2) -> R when
    S1 :: string(),
    S2 :: string(),
    R :: boolean().
common_letters(S1,S2) ->
  not sets:is_disjoint(sets:from_list(S1),sets:from_list(S2)).

-spec words_length_product(L) -> R when
    L :: [string()],
    R :: non_neg_integer().
words_length_product(L) ->
  lists:max([0 | [length(A) * length(B) || A <- L, B <- L, 
					   A < B,
					   not common_letters(A,B)]]).

-ifdef(TEST).
words_length_product_test_() ->
  [
   {"Example 1",
    ?_assertEqual(9,
		  words_length_product(
		    ["a","ab","abc","d","de","def"]))},
   {"Example 2",
    ?_assertEqual(0,
		  words_length_product(["a","aa","aaa","aaaa"]))},
   {"Example 3",
    ?_assertEqual(16,
		  words_length_product(
		    ["meet","app","code","sky","bold"]))},
   {"Example 4",
    ?_assertEqual(20,
		  words_length_product(
		    ["a","ab","abc","abcd","efghi"]))},
   {"Example 5",
    ?_assertEqual(21,
		  words_length_product(
		    ["xyz","w","abcdefg","hij"]))}
  ].
-endif.


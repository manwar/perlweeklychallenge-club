-module(ch1).
-export([alphabet_index_digit_sum/2]).
-include_lib("eunit/include/eunit.hrl").

digits_sum(N) when N >= 0 ->
  lists:sum([C - $0 || C <- integer_to_list(N)]).

alphabet_index_digit_sum(S,K) 
  when is_list(S), is_integer(K), K >= 0 ->
  NumStr = lists:foldl(fun(C,Acc) ->
			   N = C - $a + 1,
			   Acc ++ integer_to_list(N)
		       end,"",S),
  {Num,_} = string:to_integer(NumStr),
  lists:foldl(fun(_,Acc) -> digits_sum(Acc) end,Num,lists:seq(1,K)).

-ifdef(TEST).
alphabet_index_digit_sum_test_() ->
  [
   {"Example 1",
    ?_assertEqual(6,
		  alphabet_index_digit_sum("abc", 1))},
   {"Example 2",
    ?_assertEqual(9,
		  alphabet_index_digit_sum("az",2))},
   {"Example 3",
    ?_assertEqual(6,
		  alphabet_index_digit_sum("cat",1))},
   {"Example 4",
    ?_assertEqual(8,
		  alphabet_index_digit_sum("dog",2))},
   {"Example 5",
    ?_assertEqual(6,
		  alphabet_index_digit_sum("perl",3))}
  ].
-endif.


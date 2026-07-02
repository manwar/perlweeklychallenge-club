-module(ch1).
-export([sum_of_frequencies/1]).
-include_lib("eunit/include/eunit.hrl").

is_vowel(C) -> lists:member(C,"aeiouAEIOU").

sum_of_frequencies(S) ->
  Counts = [{C,length([X || X <- S, X =:= C])} || C <- lists:usort(S)],
  io:format("~p~n",[Counts]),
  {V,C} = lists:foldl(fun({C,CCount},{V,VCount}) ->
			  case is_vowel(C) of
			    true -> {max(V,CCount),VCount};
			    false -> {V,max(VCount,CCount)}
			  end
		      end,
		      {0,0},Counts),
  V + C.

-ifdef(TEST).
sum_of_frequencies_test_() ->
  [
   {"Example 1",
    ?_assertEqual(5,sum_of_frequencies("banana"))},
   {"Example 2",
    ?_assertEqual(7,sum_of_frequencies("teestett"))},
   {"Example 3",
    ?_assertEqual(3,sum_of_frequencies("aeiouuaa"))},
   {"Example 4",
    ?_assertEqual(2,sum_of_frequencies("rhythm"))},
   {"Example 5",
    ?_assertEqual(1,sum_of_frequencies("x"))}
  ].
-endif.


-module(ch1).
-export([second_largest_digit/1]).
-include_lib("eunit/include/eunit.hrl").

-spec second_largest_digit(string()) -> integer().
second_largest_digit(S) ->
  Digits = [C - $0 || C <- S, C >= $0, C =< $9],
  SortedUniq = lists:reverse(lists:usort(Digits)),
  case SortedUniq of
    [_,Second|_] -> Second;
    _ -> -1
  end.

-ifdef(TEST).
second_largest_digit_test_() ->
  [
   {"Example 1",
    ?_assertEqual(-1,second_largest_digit("aaaaa77777"))},
   {"Example 2",
    ?_assertEqual(-1,second_largest_digit("abcde"))},
   {"Example 3",
    ?_assertEqual(8,second_largest_digit("9zero8eight7seven9"))},
   {"Example 4",
    ?_assertEqual(8,second_largest_digit("xyz9876543210"))},
   {"Example 5",
    ?_assertEqual(4,second_largest_digit("4abc4def2ghi8jkl2"))}].
-endif.


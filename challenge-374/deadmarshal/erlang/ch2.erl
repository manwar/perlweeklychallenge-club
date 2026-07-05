-module(ch2).
-export([largest_same_digit_number/1]).
-include_lib("eunit/include/eunit.hrl").

-spec largest_same_digit_number(S) -> R when
    S :: string(),
    R :: {error,string()} | {ok,integer()}.
largest_same_digit_number("") -> [];
largest_same_digit_number(S) ->
  Gs = maps:values(maps:groups_from_list(fun(X) -> X end,S)),
  Ints = lists:map(fun list_to_integer/1,Gs),
  lists:max(Ints).

-ifdef(TEST).
largest_same_digit_number_test_() ->
  [
   {"Example 1",
    ?_assertEqual(3333,largest_same_digit_number("6777133339"))},
   {"Example 2",
    ?_assertEqual(4,largest_same_digit_number("1200034"))},
   {"Example 3",
    ?_assertEqual(55,largest_same_digit_number("44221155"))},
   {"Example 4",
    ?_assertEqual(88888,largest_same_digit_number("88888"))},
   {"Example 5",
    ?_assertEqual(222,largest_same_digit_number("11122233"))}
  ].
-endif.


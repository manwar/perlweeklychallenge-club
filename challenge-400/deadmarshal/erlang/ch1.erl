-module(ch1).
-export([largest_interval/1]).
-include_lib("eunit/include/eunit.hrl").

-spec has_unique_digits(X) -> R when
    X :: non_neg_integer(),
    R :: boolean().
has_unique_digits(X) ->
  Digits = integer_to_list(X),
  length(Digits) =:= length(lists:usort(Digits)).

-spec largest_interval(N) -> R when
    N :: non_neg_integer(),
    R :: non_neg_integer().
largest_interval(N) ->
  Nums = lists:filter(fun has_unique_digits/1,lists:seq(1,N)),
  case Nums of
    [] -> 0;
    [First|Rest] ->
      {_Last,Jump} =
        lists:foldl(
          fun(X,{Prev,Best}) ->
              {X,max(Best,X-Prev)}
          end,
          {First,0},
          Rest),
      Jump
  end.

-ifdef(TEST).
largest_interval_test_() ->
  [
   {"Example 1",?_assertEqual(2,largest_interval(20))},
   {"Example 2",?_assertEqual(4,largest_interval(110))},
   {"Example 3",?_assertEqual(11,largest_interval(500))},
   {"Example 4",?_assertEqual(105,largest_interval(2026))},
   {"Example 5",?_assertEqual(105,largest_interval(10000))}
  ].
-endif.


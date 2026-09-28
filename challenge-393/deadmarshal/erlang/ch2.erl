-module(ch2).
-export([prime_step/1]).
-include_lib("eunit/include/eunit.hrl").

-spec is_prime(N) -> R when
    N :: non_neg_integer(),
    R :: boolean().
is_prime(N) when N =< 1 -> false;
is_prime(N) -> not has_divisor(N,2).

-spec has_divisor(N,I) -> R when
    N :: non_neg_integer(),
    I :: non_neg_integer(),
    R :: boolean().
has_divisor(N,I) when I * I > N -> false;
has_divisor(N,I) when N rem I =:= 0 -> true;
has_divisor(N,I) -> has_divisor(N,I+1).

-spec prime_step(S) -> R when
    S :: string(),
    R :: non_neg_integer().
prime_step(S) ->
  step(lists:sum(S),0).

-spec step(Sum,D) -> R when
    Sum :: non_neg_integer(),
    D :: non_neg_integer(),
    R :: non_neg_integer().
step(Sum,D) ->
  case is_prime(Sum - D) orelse is_prime(Sum + D) of
    true -> D;
    false -> step(Sum,D+1)
  end.

-ifdef(TEST).
prime_step_test_() ->
  [
   {"Example ",?_assertEqual(9,prime_step("hello"))},
   {"Example ",?_assertEqual(2,prime_step("football"))},
   {"Example ",?_assertEqual(0,prime_step("a"))},
   {"Example ",?_assertEqual(2,prime_step("challenge"))},
   {"Example ",?_assertEqual(2,prime_step("perl"))}
  ].
-endif.


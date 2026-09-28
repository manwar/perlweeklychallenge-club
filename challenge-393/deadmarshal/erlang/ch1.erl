-module(ch1).
-export([pythagoras_multiplied/1]).
-include_lib("eunit/include/eunit.hrl").

-spec gcd(A,B) -> R when
    A :: non_neg_integer(),
    B :: non_neg_integer(),
    R :: non_neg_integer().
gcd(A,0) -> A;
gcd(A,B) -> gcd(B,A rem B).

-spec pythagoras_multiplied(N) -> R when
    N :: non_neg_integer(),
    R :: non_neg_integer().
pythagoras_multiplied(N) ->
  MMax = max(trunc(math:sqrt(N-1)),1),
  lists:sum([2 * (N div C) ||
	      M <- lists:seq(2,MMax),
	      K <- lists:seq(1,M-1),
	      (M - K) rem 2 =:= 1,
	      gcd(M,K) =:= 1,
	      C <- [M * M + K * K],
	      C =< N]).

-ifdef(TEST).
pythagoras_multiplied_test_() ->
  [
   {"Example ",?_assertEqual(12,pythagoras_multiplied(20))},
   {"Example ",?_assertEqual(2,pythagoras_multiplied(7))},
   {"Example ",?_assertEqual(0,pythagoras_multiplied(1))},
   {"Example ",?_assertEqual(8,pythagoras_multiplied(15))},
   {"Example ",?_assertEqual(22,pythagoras_multiplied(30))}
  ].
-endif.


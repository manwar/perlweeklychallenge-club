-module(ch2).
-author("Ali Moradi").
-export([sum_difference/1]).

sum_difference(L) ->
  {Sum1, Sum2} = sum_difference(L, 0, 0),
  abs(Sum1 - Sum2).

sum_difference([], Sum1, Sum2) -> {Sum1, Sum2};
sum_difference([H | T], Sum1, Sum2) ->
  sum_difference(T, Sum1 + H, Sum2 + sum_digits(H)).

sum_digits(N) ->
  sum_digits(N, 10).

sum_digits(N, B) ->
  sum_digits(N, B, 0).

sum_digits(0, _, Acc) -> Acc;
sum_digits(N, Base, Acc) when N < Base -> Acc + N;
sum_digits(N, Base, Acc) -> sum_digits(N div Base, Base, Acc + (N rem Base)).

-module(ch1).
-author("Ali Moradi").
-export([maximum_count/1]).

maximum_count(L) ->
  {Neg, Pos} = maximum_count(L, 0, 0),
  max(Neg, Pos).

maximum_count([], Neg, Pos) -> {Neg, Pos};
maximum_count([H | T], Neg, Pos) when H < 0 ->
  maximum_count(T, Neg + 1, Pos);
maximum_count([H | T], Neg, Pos) when H > 0 ->
  maximum_count(T, Neg, Pos + 1);
maximum_count([H | T], Neg, Pos) when H =:= 0 ->
  maximum_count(T, Neg, Pos).

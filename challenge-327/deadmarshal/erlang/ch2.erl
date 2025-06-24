-module(ch2).
-export([mad/1]).

-spec zip(L1,L2) -> R when
    L1 :: [T],
    L2 :: [T],
    R :: [{T,T}],
    T :: integer().
zip(L1, L2) -> lists:reverse(zip(L1, L2, [])).

-spec zip(L1,L2,R) -> R when
    L1 :: [T],
    L2 :: [T],
    R :: [{T,T}],
    T :: integer().
zip([], _, Acc) -> Acc;
zip(_, [], Acc) -> Acc;
zip([X | Xs], [Y | Ys], Acc) ->
  zip(Xs, Ys, [{X, Y} | Acc]).

-spec mad(L) -> R when
    L :: [T],
    R :: [{T,T}],
    T :: integer().
mad([]) -> [];
mad([_]) -> [];
mad(L) ->
  Sorted = lists:sort(L),
  Pairs = zip(Sorted,tl(Sorted)),
  Diffs = lists:map(fun({A,B}) -> abs(A - B) end,Pairs),
  Min = lists:min(Diffs),
  [{A,B} || {A,B} <- Pairs, abs(A - B) =:= Min].


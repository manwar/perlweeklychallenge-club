-module(ch1).
-export([missing_integers/1]).

-spec missing_integers(L) -> R when
    L :: [T],
    R :: sofs:external_set(),
    T :: term().
missing_integers(L) ->
  S1 = sofs:set(L),
  S2 = sofs:set(lists:seq(1,length(L))),
  sofs:to_external(sofs:symdiff(S1,S2)).


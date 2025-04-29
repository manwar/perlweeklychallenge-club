-module(ch1).
-author("Ali Moradi").
-export([word_count/1]).
-include_lib("eunit/include/eunit.hrl").

-spec word_count(list()) -> integer().
word_count(List) -> aux(List, 0).

-spec aux(list(), integer()) -> integer().
aux([], Acc) -> Acc;
aux([H | T], Acc) ->
  case contains_vowels(H) of
    true -> aux(T, Acc + 1);
    false -> aux(T, Acc)
  end.

-spec contains_vowels(list()) -> boolean().
contains_vowels(String) ->
  Vowels = "aeiouAEIOU",
  S = [hd(String), lists:last(String)],
  lists:any(fun(Char) -> lists:member(Char, Vowels) end, S).

-ifdef(TEST).
simple_test() ->
  [?assertEqual(2, ch1:word_count(["unicode", "xml", "raku", "perl"])),
    ?assertEqual(2, ch1:word_count(["the", "weekly", "challenge"])),
    ?assertEqual(0, ch1:word_count(["perl", "python", "postgres"]))].
-endif.

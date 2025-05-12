-module(ch2).
-author("Ali Moradi").
-export([backspace_compare/2]).

backspace_compare(S1, S2) ->
  process_string(S1) =:= process_string(S2).

process_string(S) ->
  process_string(S, []).

process_string([], Acc) -> lists:reverse(Acc);
process_string([$# | T], [_ | AccT]) -> % remove one character from Acc
  process_string(T, AccT);
process_string([C | T], Acc) -> % normal character
  process_string(T, [C | Acc]).


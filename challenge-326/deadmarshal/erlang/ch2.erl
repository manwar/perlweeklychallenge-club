-module(ch2).
-export([decompressed_list/1]).

-spec pairs(L,L) -> R when 
    L :: [T],
    R :: [T],
    T :: integer().
pairs([],Acc) -> lists:reverse(Acc);
pairs([A,B|T],Acc) -> pairs(T,[{A,B}|Acc]).

-spec decompressed_list(L) -> R when 
    L :: [T],
    R :: [T],
    T :: integer().
decompressed_list(L) ->
  lists:flatmap(fun({A,B}) -> lists:duplicate(A,B) end,pairs(L,[])).


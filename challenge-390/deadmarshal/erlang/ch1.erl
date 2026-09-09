-module(ch1).
-export([decode_string/1]).
-include_lib("eunit/include/eunit.hrl").

-spec decode_string(S) -> R when
    S :: string(),
    R :: string().
decode_string("") -> "";
decode_string(S) ->
  decode_string(S,[],[],0,"").

-spec decode_string(S,S1,S2,Num,Res) -> R when
    S :: string(),
    S1 :: [non_neg_integer()],
    S2 :: [string()],
    Num :: non_neg_integer(),
    Res :: string(),
    R :: string().
decode_string([H|T],S1,S2,Num,Res) when H >= $0 andalso H =< $9 ->
  decode_string(T,S1,S2,Num * 10 + H - $0,Res);
decode_string([$[|T],S1,S2,Num,Res) ->
  decode_string(T,[Num|S1],[Res|S2],0,"");
decode_string([$]|T],[Popped1|S1T],[Popped2|S2T],Num,Res) ->
  Temp = string:copies(Res,Popped1),
  decode_string(T,S1T,S2T,Num,Popped2 ++ Temp);
decode_string([H|T],S1,S2,Num,Res) ->
  decode_string(T,S1,S2,Num,Res ++ [H]);
decode_string("",_S1,_S2,_Num,Res) -> 
  Res.

-ifdef(TEST).
decode_string_test_() ->
  [
   {"Example 1",
    ?_assertEqual("aaaaaa",decode_string("2[3[a]]"))},
   {"Example 2",
    ?_assertEqual("aaaaaaaaaa",decode_string("10[a]"))},
   {"Example 3",
    ?_assertEqual("abbcddde",decode_string("a2[b]c3[d]e"))},
   {"Example 4",
    ?_assertEqual("abbcabbc",decode_string("2[a2[b]c]"))},
   {"Example 5",
    ?_assertEqual("abcccbccc",decode_string("1[a]2[b3[c]]"))}
  ].
-endif.


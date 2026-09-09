-module(ch2).
-export([order_characters/2]).
-include_lib("eunit/include/eunit.hrl").

-spec order_characters(S,K) -> R when
    S :: string(),
    K :: non_neg_integer(),
    R :: string().
order_characters("",_K) -> "";
order_characters(S,K) when K =:= 1 ->
  N = length(S),
  Doubled = S ++ S,
  lists:foldl(fun(I,Acc) -> 
		  Cand = string:sub_string(Doubled,I,I+N-1),
		  if Cand < Acc -> Cand;
		     true -> Acc
		  end
	      end,string:sub_string(Doubled,1,N),lists:seq(1,N));
order_characters(S,_K) -> 
  lists:sort(S).

-ifdef(TEST).
order_characters_test_() ->
  [
   {"Example 1",
    ?_assertEqual("adbc",order_characters("dbca",1))},
   {"Example 2",
    ?_assertEqual("eegks",order_characters("geeks",2))},
   {"Example 3",
    ?_assertEqual("abcde",order_characters("cbaed",3))},
   {"Example 4",
    ?_assertEqual("abcdef",order_characters("fedcba",4))},
   {"Example 5",
    ?_assertEqual("erlp",order_characters("perl",1))},
   {"Example 6",
    ?_assertEqual("looloooo",order_characters("oloolooo",1))},
   {"Example 7",
    ?_assertEqual("looloooo",order_characters("oloooolo",1))}
  ].
-endif.


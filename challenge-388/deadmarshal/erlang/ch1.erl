-module(ch1).
-export([dyck_words/1]).
-include_lib("eunit/include/eunit.hrl").

-spec dyck_words(N) -> R when
    N :: non_neg_integer(),
    R :: [string()].
dyck_words(0) -> [""];
dyck_words(N) -> 
  lists:sort(dyck_words(N,0,0,[])).

-spec dyck_words(N,Open,Close,Acc) -> R when
    N :: non_neg_integer(),
    Open :: non_neg_integer(),
    Close :: non_neg_integer(),
    Acc :: [string()],
    R :: [string()].
dyck_words(N,N,N,Acc) ->
  [lists:reverse(Acc)];
dyck_words(N,Open,Close,Acc) ->
  lists:append([case Open < N of 
		  true -> dyck_words(N,Open+1,Close,[$U|Acc]);
		  false -> []
		end,
		case Close < N andalso Open > Close of 
		  true -> dyck_words(N,Open,Close+1,[$D|Acc]);
		  false -> []
		end]).

-ifdef(TEST).
dyck_words_test_() ->
  [
   {"Example 1",
    ?_assertEqual(["UD"],dyck_words(1))},
   {"Example 2",
    ?_assertEqual(["UDUD","UUDD"],dyck_words(2))},
   {"Example 3",
    ?_assertEqual(["UDUDUD","UDUUDD",
		   "UUDDUD","UUDUDD",
		   "UUUDDD"],dyck_words(3))},
   {"Example 4",
    ?_assertEqual([""],dyck_words(0))},
   {"Example 5",
    ?_assertEqual(["UDUDUDUD","UDUDUUDD",
		   "UDUUDDUD","UDUUDUDD",
		   "UDUUUDDD","UUDDUDUD",
		   "UUDDUUDD","UUDUDDUD",
		   "UUDUDUDD","UUDUUDDD",
		   "UUUDDDUD","UUUDDUDD",
		   "UUUDUDDD","UUUUDDDD"],dyck_words(4))}].
-endif.


-module(ch1).
-export([count_prefixes/2]).
-include_lib("eunit/include/eunit.hrl").

-spec count_prefixes([string()],string()) -> non_neg_integer().
count_prefixes(L,S) ->
  lists:foldl(fun(E,Acc) ->
		  case string:prefix(S,E) of 
		    nomatch -> Acc;
		    _ -> Acc+1
		  end
	      end,0,L).

-ifdef(TEST).
count_prefixes_test_() ->
  [
   {"Example 1",
    ?_assertEqual(4,
		  count_prefixes(["a","ap","app","apple","banana"],
				 "apple"))},
   {"Example 2",
    ?_assertEqual(0,
		  count_prefixes(["cat","dog","fish"],"bird"))},
   {"Example 3",
    ?_assertEqual(4,
		  count_prefixes(["hello","he","hell","heaven","he"],
				 "hello"))},
   {"Example 4",
    ?_assertEqual(3,
		  count_prefixes(["","code","coding","cod"],
				 "coding"))},
   {"Example 5",
    ?_assertEqual(7,
		  count_prefixes(["p","pr","pro","prog",
				  "progr","progra","program"],
				 "program"))}
  ].
-endif.


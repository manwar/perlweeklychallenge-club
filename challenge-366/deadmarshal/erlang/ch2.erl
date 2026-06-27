-module(ch2).
-export([valid_times/1]).
-include_lib("eunit/include/eunit.hrl").

-spec valid_times(string()) -> non_neg_integer().
valid_times([H1,H2,$:,M1,M2]) ->
  Hours = case {H1,H2} of
	    {$?,$?} -> 24;
	    {$?,H} when H < $4 -> 3;
	    {$?,_} -> 2;
	    {H,$?} when H < $2 -> 10;
	    {_,$?} -> 4;
	    {_,_} -> 1
	  end,
  Minutes = case M1 of
	      $? -> 6;
	      _ -> 1
	    end * case M2 of
		    $? -> 10;
		    _ -> 1
		  end,
  Hours * Minutes.

-ifdef(TEST).
valid_times_test_() ->
  [
   {"Example 1",
    ?_assertEqual(3,valid_times("?2:34"))},
   {"Example 2",
    ?_assertEqual(12,valid_times("?4:?0"))},
   {"Example 3",
    ?_assertEqual(1440,valid_times("??:??"))},
   {"Example 4",
    ?_assertEqual(3,valid_times("?3:45"))},
   {"Example 5",
    ?_assertEqual(4,valid_times("2?:15"))}
  ].
-endif.


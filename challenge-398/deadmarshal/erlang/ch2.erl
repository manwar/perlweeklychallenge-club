-module(ch2).
-export([string_difference/1]).
-include_lib("eunit/include/eunit.hrl").

-spec string_difference(L) -> R when
    L :: [string()],
    R :: {ok,string()} | {error,string()}.
string_difference(Words) ->
  Keyed = [{diffs(W),W} || W <- Words],
  Counts = lists:foldl(
	     fun({K,_},M) -> 
		 maps:update_with(K,fun(C) -> C+1 end,1,M) end,
	     #{},
	     Keyed),
  find_unique(Keyed, Counts).

-spec diffs(S) -> R when
    S :: string(),
    R :: [integer()].
diffs([A,B|T]) -> [B-A|diffs([B|T])];
diffs(_) -> [].

-spec find_unique(Words,Counts) -> R when
    Words :: [{[integer()], string()}],
    Counts :: #{[integer()] => pos_integer()},
    R :: {ok,string()} | {error,string()}.
find_unique([],_Counts) -> {error,""};
find_unique([{K,W}|Rest],Counts) ->
  case maps:get(K,Counts) of
    1 -> {ok,W};
    _ -> find_unique(Rest,Counts)
  end.

-ifdef(TEST).
string_difference_test_() ->
  [
   {"Example 1",?_assertEqual({ok,"zy"},
			      string_difference(["ab","bc",
						 "cd","zy"]))},
   {"Example 2",?_assertEqual({ok,"azy"},
			      string_difference(["cba","fed","azy"]))},
   {"Example 3",?_assertEqual({ok,"pop"},
			      string_difference(["pop","ada",
						 "beb","cfc"]))},
   {"Example 4",?_assertEqual({ok,"aaba"},
			      string_difference(["aaaa","zzzz",
						 "mmmm","aaba"]))},
   {"Example 5",?_assertEqual({ok,"azbz"},
			      string_difference(["aceg","bdfh",
						 "cegi","azbz"]))}
  ].
-endif.


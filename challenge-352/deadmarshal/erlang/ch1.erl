-module(ch1).
-export([match_string/1,main/0]).

-spec match_string([string()]) -> [string()].
match_string(L) ->
  match_string(L,L,[]).

-spec match_string([string()],[string()],[string()]) -> [string()].
match_string([],_,Acc) ->
  lists:reverse(Acc);
match_string([A|Rest],Strs,Acc) ->
  case is_contained_in_others(A,Strs) 
    andalso not lists:member(A,Acc) of 
    true -> match_string(Rest,Strs,[A|Acc]);
    false -> match_string(Rest,Strs,Acc)
  end.

-spec is_contained_in_others(string(),[string()]) -> boolean().
is_contained_in_others(A,Strs) ->
  lists:any(fun(B) -> string:str(B,A) > 0 andalso B =/= A end,Strs).

main() ->
  io:format("~p~n~p~n~p~n~p~n~p~n",
	    [match_string(["cat","cats","dog","dogcat",
			   "dogcat","rat","ratcatdogcat"]),
	     match_string(["hello","hell","world","wor",
			   "ellow","elloworld"]),
	     match_string(["a", "aa", "aaa", "aaaa"]),
	     match_string(["flower","flow","flight","fl",
			   "fli","ig","ght"]),
	     match_string(["car","carpet","carpenter","pet",
			   "enter","pen","pent"])]).


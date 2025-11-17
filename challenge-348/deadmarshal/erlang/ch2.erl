-module(ch2).
-export([convert_time/2,main/0]).

-spec to_min(string()) -> integer().
to_min(S) ->
  [HStr,MStr] = string:split(S,":",all),
  H = list_to_integer(HStr),
  M = list_to_integer(MStr),
  H * 60 + M.

-spec convert_time(string(),string()) -> integer().
convert_time(Source,Target) ->
  A = to_min(Source),
  B = to_min(Target),
  D = (B - A + 1440) rem 1440,
  {Res,_} = lists:foldl(fun(Step,{Acc,Rem}) ->
			    {Acc + (Rem div Step), Rem rem Step}
			end,{0,D},[60,15,5,1]),
  Res.

main() ->
  io:format("~p~n~p~n~p~n~p~n~p~n",
	    [convert_time("02:30","02:45"),
	     convert_time("11:55","12:15"),
	     convert_time("09:00","13:00"),
	     convert_time("23:45","00:30"),
	     convert_time("14:20","15:25")]).


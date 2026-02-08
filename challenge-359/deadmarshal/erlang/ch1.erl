-module(ch1).
-export([digital_root/1,main/0]).

-spec digital_root(integer()) -> integer().
digital_root(N) ->
  digital_root(N,0).

-spec digital_root(integer(),integer()) -> integer().
digital_root(N,Pers) when N < 10 -> {Pers,N};
digital_root(N,Pers) ->
  Sum = lists:sum([C - $0 || C <- integer_to_list(N)]),
  digital_root(Sum,Pers+1).

main() ->
  Numbers = [38,7,999,1999999999,101010],
  lists:foreach(fun(N) -> 
		    {Pers, Root} = digital_root(N),
		    io:format("Persistence  = ~p~nDigital Root = ~p~n", 
			      [Pers,Root]) end,Numbers).


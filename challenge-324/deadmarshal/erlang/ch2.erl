-module(ch2).
-export([total_xor/1]).
  
total_xor(L) ->
  Ls = lists:map(fun(L) -> lists:foldl(fun erlang:'bxor'/2,0,L) end,
		 subsets(L)),
  lists:foldl(fun erlang:'+'/2,0,Ls).

subsets(L) ->
  N = length(L),
  Max = trunc(math:pow(2,N)),
  subsets(L,0,N,Max,[]).

subsets(L,I,N,Max,Acc) when I < Max ->
  Subset = [lists:nth(Pos+1,L) || Pos <- lists:seq(0,N-1),
				   I band (1 bsl Pos) =/= 0],
  subsets(L,I+1,N,Max,[Subset|Acc]);
subsets(_,_,_,_,Acc) -> Acc.


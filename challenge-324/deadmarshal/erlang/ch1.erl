-module(ch1).
-export([twod_array/3]).

twod_array(L,R,C) when length(L) / C == R -> 
  chunk_every(L,C);
twod_array(_,_,_) -> [].

chunk_every(L,N) when N > 0 ->
  chunk_every(L,N,[]).

chunk_every([],_,Acc) ->
  lists:reverse(Acc);
chunk_every(L,N,Acc) ->
  case L of 
    _ when length(L) >= N ->
      {Chunk,Rest} = lists:split(N,L),
      chunk_every(Rest,N,[Chunk|Acc]);
    _ -> lists:reverse([L|Acc])
  end.


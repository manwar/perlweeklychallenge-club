
  
  make_kv(K, V, K-V).
  make_kv(L, KV):-
      L = [H|T],
      maplist(make_kv(H), T, KV1),
      reverse(L, LR),
      LR = [HR|TR],
      maplist(make_kv(HR), TR, KVR),
      append(KV1, KVR, KV).
  make_kvs([], []).
  make_kvs([H|T], [KV|KVs]):-
      make_kvs(T, KVs),
      make_kv(H, KV).

  
  similar(L1, L2, M):-
      make_kvs(M, KV1),
      flatten(KV1, KVs),
      phrase(similar(KVs, L1), L2). 

  
  similar(_, []) --> [].
  similar(_, []) --> [_], {!, fail}.
  similar(KVs, L) --> [W], {L = [H|T], (H == W; member(H-W, KVs); 
                            member(W-H, KVs))}, similar(KVs, T).


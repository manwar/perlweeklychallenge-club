
  
  decompression(Decompression), [Decompression] --> [Decompression].
  decompression(D, Decompression), [Decompression] --> [D].

  
  decompress(Input) --> decompression(D, Decompression),
                     {Input = [I, J|T],
                      length(L, I),
                      maplist(=(J), L),
                      append(D, L, Decompression)
                      },
                      decompress(T).
  decompress([]) --> [].

  
  decompress_list(L, Decompressed):-
      phrase(decompress(L), [[]], [Decompressed]).


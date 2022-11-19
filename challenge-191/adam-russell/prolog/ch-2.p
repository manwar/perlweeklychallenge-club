cute(_, _) --> [].
cute(N, CuteList) --> [X], {between(1, N, X), \+ member(X, CuteList), 
                            append(CuteList, [X], CuteListUpdated),
                            nth(I, CuteListUpdated, X),
                            0 is mod(X, I)}, 
                            cute(N, CuteListUpdated).
cute(N, CuteList) --> [X], {between(1, N, X), \+ member(X, CuteList), 
                            append(CuteList, [X], CuteListUpdated),
                            nth(I, CuteListUpdated, X),
                            0 is mod(I, X)}, 
                            cute(N, CuteListUpdated).       
                            
%N = 10, findall(Cute, (length(Cute, N), phrase(cute(N, []), Cute)), C), sort(C, CuteList), length(CuteList, NumberCuteList).                     
    
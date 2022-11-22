cute(_, _) --> [].
cute(N, CuteList) --> [X], {between(1, N, X), \+ member(X, CuteList), 
                            length(CuteList, CuteListLength),
                            succ(CuteListLength, I),
                            (0 is mod(X, I); 0 is mod(I, X)),
                            append(CuteList, [X], CuteListUpdated)}, 
                            cute(N, CuteListUpdated).
                            
main:-
    N = 15, 
    findall(Cute, (length(Cute, N), phrase(cute(N, []), Cute)), C), 
    sort(C, CuteList), 
    length(CuteList, NumberCuteList),
    write(NumberCuteList), nl.                            
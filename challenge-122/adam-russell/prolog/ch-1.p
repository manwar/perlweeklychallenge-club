:-initialization(main).

moving_average(N):-
    moving_average(0, N, 1). 
moving_average(Sum, N, I):-
    I \== N,  
    Sum0 is Sum + (I * 10),
    Average is Sum0 / I,
    write(Average), nl,
    I0 is I + 1,
    moving_average(Sum0, N, I0).  
moving_average(_, N, I):-
    I == N.   

main:-
    moving_average(10),
    halt. 

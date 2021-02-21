:-initialization(main).

hour_to_12(H12, H24):-
    append(H, [58|R], H24), 
    number_codes(N0, H),
    N is N0 - 12,
    number_codes(N, C0),
    flatten([C0, 58, R], C),  
    atom_codes(A, C), 
    H12 = A. 

hour_to_24(H12, H24):-
    append(H, [58|R], H12), 
    number_codes(N0, H),
    N is N0 + 12,
    number_codes(N, C0),
    flatten([C0, 58, R], C),  
    atom_codes(A, C), 
    H24 = A. 

twenty_four_hour(H12, H24):-
    nonvar(H12),
    hour_to_24(H12, H24). 
twenty_four_hour(H12, H24):-
    nonvar(H24),
    hour_to_12(H12, H24). 

main:-
    twenty_four_hour("05:15 pm", HOUR_24),
    write(HOUR_24), nl,
    twenty_four_hour(HOUR_12, "17:15 pm"),
    write(HOUR_12), nl,
    halt. 

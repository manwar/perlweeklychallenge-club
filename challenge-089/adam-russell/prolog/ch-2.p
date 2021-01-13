all_unique(_, []).
all_unique(L, [V|T]) :-
    fd_exactly(1, L, V),
    all_unique(L, T).

pwc_matrix(R1,R2,R3) :-
    R1 = [A, B, C],
    R2 = [D, E, F],
    R3 = [G, H, I],
    /* each element is a number from 1 to 9 */  
    fd_domain([A, B, C], 1, 9),
    fd_domain([D, E, F], 1, 9),
    fd_domain([G, H, I], 1, 9),
    /* ensure each element is unique */
    all_unique([A, B, C, D, E, F, G, H, I], [1, 2, 3, 4, 5, 6, 7, 8, 9]),
    /* row constraints */
    A + B + C #= 15,
    D + E + F #= 15,
    G + H + I #= 15,
    /* column constraints */
    A + D + G #= 15,
    B + E + H #= 15,
    C + F + I #= 15,
    /* diagonal constraints */
    A + E + I #= 15,
    C + E + G #= 15,
    /* label all variables to instantiate one solution */  
    fd_labeling([A, B, C, D, E, F, G, H, I]).  

write_rows([]).
write_rows([H|T]):-
    format('[ ~d ~d ~d ]~n', H),
    write_rows(T).

write_solutions([]). 
write_solutions([H|T]):-
   write_rows(H), 
   nl,
   write_solutions(T). 

main :-
    findall([R1,R2,R3], pwc_matrix(R1,R2,R3), Solutions),  
    write_solutions(Solutions). 
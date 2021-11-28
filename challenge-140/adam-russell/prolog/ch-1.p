:-initialization(main).

sum_carry(0, 0, 1, 1, 1).  
sum_carry(1, 0, 1, 0, 0).  
sum_carry(0, 1, 1, 1, 0). 
sum_carry(0, 1, 0, 1, 1). 
sum_carry(0, 0, 0, 0, 0). 
sum_carry(1, 0, 0, 0, 1).  
sum_carry(0, 1, 1, 0, 1). 
sum_carry(1, 0, 0, 1, 0). 
sum_carry(0, 1, 1, 1).   
sum_carry(1, 0, 0, 1). 
sum_carry(0, 0, 0, 0). 
sum_carry(1, 0, 1, 0).    

add_binary(A, B, Sum):-
    number_chars(A, AChars),   
    number_chars(B, BChars),        
    reverse(AChars, ACharsReverse),  
    reverse(BChars, BCharsReverse),  
    add_binary(ACharsReverse, BCharsReverse, 0, [], Sum).  
add_binary([], [], 0, SumAccum, Sum):-
    number_chars(Sum, SumAccum).  
add_binary([], [], 1, SumAccum, Sum):-   
    number_chars(Sum, ['1'|SumAccum]).  
add_binary([H|T], [], Carry, SumAccum, Sum):-
    number_chars(D, [H]), 
    sum_carry(S, C, D, Carry), 
    number_chars(S, [N]),  
    add_binary(T, [], C, [N | SumAccum], Sum).  
add_binary([H0|T0], [H1|T1], Carry, SumAccum, Sum):-
    number_chars(D0, [H0]), 
    number_chars(D1, [H1]), 
    sum_carry(S, C, D0, D1, Carry), 
    number_chars(S, [N]),  
    add_binary(T0, T1, C, [N | SumAccum], Sum).  

main:-
    add_binary(11, 1, X0),
    write(X0), nl, 
    add_binary(101, 1, X1),
    write(X1), nl, 
    add_binary(100, 11, X2),
    write(X2), nl, 
    halt. 

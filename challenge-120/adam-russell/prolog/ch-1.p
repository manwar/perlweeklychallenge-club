:-initialization(main).

pad(Bits, Padded):-
    length(Bits, L),
    PadLength is 8 - L, 
    length(Padding, PadLength),  
    maplist(=(0), Padding),
    append(Padding, Bits, Padded).  

bits(N, Bits):-
    bits(N, [], Bits).
bits(0, Bits, Bits).    
bits(N, Bit_Accum, Bits):-    
    B is N /\ 1,
    N0 is N >> 1,
    bits(N0, [B|Bit_Accum], Bits).

swap([], []). 
swap([H0, H1|T], [H1, H0|ST]):-
    swap(T, ST).

decimal(Bits, Decimal):-
    decimal(Bits, 0, Decimal).
decimal([], Decimal, Decimal).
decimal([H|T], DecimalAccum, Decimal):-
    length([H|T], B), 
    D is (H * 2 ** (B - 1)) + DecimalAccum,
    decimal(T, D, Decimal).  

main:-
    bits(18, B),
    pad(B, Padded),  
    swap(Padded, Swapped), 
    decimal(Swapped, Decimal), 
    write(Decimal), nl,
    halt.

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

flip_nth_bit(N, Bits, NthFlipped):-
    N0 is 9 - N, 
    N1 is 8 - N, 
    nth(N0, Bits, B),
    Flipped is xor(B, 1),
    length(Bits0, N1),
    append(Bits0, [B|T], Bits), 
    append(Bits0, [Flipped|T], NthFlipped).

decimal(Bits, Decimal):-
    decimal(Bits, 0, Decimal).
decimal([], Decimal, Decimal).
decimal([H|T], DecimalAccum, Decimal):-
    length([H|T], B), 
    D is (H * 2 ** (B - 1)) + DecimalAccum,
    decimal(T, D, Decimal).  

main:-
    bits(12, B),
    pad(B, Padded),  
    flip_nth_bit(3, Padded, Flipped), 
    decimal(Flipped, Decimal), 
    write(Decimal), nl,
    halt.

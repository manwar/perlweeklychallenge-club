bits(N, Bits):-
    bits(N, [], Bits).    
bits(0, Bits, Bits):-!.
bits(N, BitsAccum, Bits):-
    B is N /\ 1,
    N0 is N >> 1,
    bits(N0, [B|BitsAccum], Bits).

bits_reverse(B, RB):-
    Flipped is xor(B, 1),
    number_chars(Flipped, [RB]).
    
binary_flip(N, NBitsReversed):-
    bits(N, Bits), 
    maplist(bits_reverse, Bits, BitsReversed),
    number_chars(NBitsReversed, ['0','b'|BitsReversed]).
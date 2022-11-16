digits([1, 2]).

alphabet(1, 'A').
alphabet(2, 'B').
alphabet(3, 'C').
alphabet(4, 'D').
alphabet(5, 'E').
alphabet(6, 'F').
alphabet(7, 'G').
alphabet(8, 'H').
alphabet(9, 'I').
alphabet(10,'J').
alphabet(11, 'K').
alphabet(12, 'L').
alphabet(13, 'M').
alphabet(14, 'N').
alphabet(15, 'O').
alphabet(16, 'P').
alphabet(17, 'Q').
alphabet(18, 'R').
alphabet(19, 'S').
alphabet(20, 'T').
alphabet(21, 'U').
alphabet(22, 'V').
alphabet(23, 'W').
alphabet(24, 'X').
alphabet(25, 'Y').
alphabet(26, 'Z').

list_chunks(_, [], []).
list_chunks(List, [H|T], [PrefixNumber|RestNumbers]):-
    length(Prefix, H),
    prefix(Prefix, List),
    append(Prefix, Rest, List),
    number_codes(PrefixNumber, Prefix),
    list_chunks(Rest, T, RestNumbers).

sum(Digits, Length):-
    sum([], Digits, Length, 0).

sum(Digits, Digits, _, _). 
sum(Partial, Digits, Length, Sum):-   
    Sum < Length, 
    digits(L),
    member(X, L),
    S is Sum + X,
    sum([X | Partial], Digits, Length, S). 
    
decode(Encoded, Decoded):-
    number_codes(Encoded, EncodedCodes),
    length(EncodedCodes, EncodedLength),
    findall(Digits,(
        sum(Digits, EncodedLength), 
        sum_list(Digits, EncodedLength)), DigitList),
    findall(Chunks, (
        member(ChunkSizes, DigitList),
        list_chunks(EncodedCodes, ChunkSizes, Chunks)), ChunkList),
    findall(DecodedChunk,(
        member(C, ChunkList),
        maplist(alphabet, C, DecodedChunkChars),
        atom_chars(DecodedChunk, DecodedChunkChars)), Decoded).
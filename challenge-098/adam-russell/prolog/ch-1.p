:-dynamic(position/1).
:-initialization(main).

position(0).

read_n_chars(Stream, N, Chars):-
    read_n_chars(Stream, N, [], Chars).
read_n_chars(_, 0, ByteAccum, Chars):-
    atom_codes(Chars, ByteAccum).    
read_n_chars(Stream, N, ByteAccum, Chars):-
    \+ at_end_of_stream(Stream),
    get_byte(Stream, C),
    N0 is N - 1,
    append(ByteAccum, [C], ByteAccum0),
    read_n_chars(Stream, N0, ByteAccum0, Chars).
read_n_chars(Stream, _, ByteAccum, Chars):-
    at_end_of_stream(Stream),
    read_n_chars(Stream, 0, ByteAccum, Chars).
    
read_n(File, N, Chars):-
    open(File, read, Stream,[type(binary),reposition(true)]),
    position(Position),
    seek(Stream, bof, Position, _),
    read_n_chars(Stream, N, Chars),
    X is N + Position,
    retract(position(Position)),
    asserta(position(X)),
    close(Stream).
    
main:-
    read_n('../ch-1.dat', 4, Chars0),
    write(Chars0), nl,
    read_n('../ch-1.dat', 4, Chars1),
    write(Chars1), nl,
    read_n('../ch-1.dat', 4, Chars2),
    write(Chars2), nl,
    halt.
check_and_read(10, [] ,_):-
    !.
check_and_read(13, [], _):-
    !.
check_and_read(32, [], _):-
    !.
check_and_read(44, [], _):-
    !.
check_and_read(end_of_file, [], _):-
    !.
check_and_read(Char, [Char|Chars], Stream):-
    get_code(Stream, NextChar),
    check_and_read(NextChar, Chars, Stream).

read_data(Stream, []):-
    at_end_of_stream(Stream).
read_data(Stream, [X|L]):-
    \+ at_end_of_stream(Stream),
    get_code(Stream, Char),
    check_and_read(Char, Chars, Stream),
    atom_codes(X, Chars),
    read_data(Stream, L).

abecedarian(Words, Abecedarian):-
    member(Word, Words),
    atom_chars(Word, Chars),
    sort(Chars, SortedChars),
    atom_chars(W, SortedChars),
    W = Word,
    Abecedarian = Word.

word_length(Word, LengthWord):-
    atom_chars(Word, Chars),
    length(Chars, Length),
    LengthWord = Length-Word. 

abecedarians(Words, Abecedarians):-
    findall(Abecedarian, abecedarian(Words, Abecedarian), A),
    maplist(word_length, A, AL), 
    keysort(AL, ALSorted),
    reverse(ALSorted, Abecedarians).
    
main:-
    open('dictionary', read, Stream),
    read_data(Stream, Dictionary),
    close(Stream),
    abecedarians(Dictionary, Abecedarians),
    write(Abecedarians), nl, 
    halt.
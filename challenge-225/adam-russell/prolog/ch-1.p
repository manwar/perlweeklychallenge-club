check_and_read(32, [], _):-
    !.
check_and_read(46, [], _):-
    !. 
check_and_read(-1, [], _):-
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

sentence_atoms(Sentence, Atoms):-
    open_input_codes_stream(Sentence, Stream),
    read_data(Stream, Atoms).
    
max_sentence_length(Sentences, MaxLength):-
    maplist(sentence_atoms, Sentences, SentenceAtoms),
    maplist(length, SentenceAtoms, Lengths),
    max_list(Lengths, MaxLength).
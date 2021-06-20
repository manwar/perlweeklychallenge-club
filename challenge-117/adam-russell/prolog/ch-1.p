:-initialization(main).

check_and_read(10, [] ,_):-
    !.
check_and_read(13, [], _):-
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

line_numbers([], []).  
line_numbers([N0,_|T], [N1|N]):-
    number_atom(N1, N0),
    line_numbers(T, N). 

missing(Contents, Missing):-
    line_numbers(Contents, Numbers),
    max_list(Numbers, Max),
    min_list(Numbers, Min),
    between(Min, Max, X),
    \+ member(X, Numbers),
    Missing = X. 

main:-
    open('data', read, Stream),
    read_data(Stream, Contents),
    close(Stream),
    missing(Contents, Missing),
    format('Missing: ~d ~N', [Missing]), 
    halt.   

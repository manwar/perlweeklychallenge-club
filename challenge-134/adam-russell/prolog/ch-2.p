:-initialization(main).

table(M, N, K):-
    between(1, M, I),
    between(1, N, J),
    K is I * J.

print_table(M, N, Distinct):-
    findall(K, table(M, N, K), Ks),
    setof(K, table(M, N, K), Distinct),
    print_header(M, N),
    print_seperator(M, N),
    print_rows(M, N, Ks),
    maplist(number_chars, Distinct, DistinctRow), 
    maplist(add_space, DistinctRow, DistinctSpaced),
    flatten(DistinctSpaced, DistinctSpacedFlattened),
    format("~nDistinct Terms: ~S~n", [DistinctSpacedFlattened]),
    length(Distinct, Count),
    format("Count: ~d ~n", [Count]).

print_rows(0, _, _).
print_rows(M, N, Products):-
    length(Row, N),
    append(Rest, Row, Products),
    M0 is M - 1,
    print_rows(M0, N, Rest),
    maplist(number_chars, Row, RowChars), 
    maplist(add_space, RowChars, CharsSpaced),
    flatten(CharsSpaced, CharsSpacedFlattened),
    format(" ~n  ~d | ~S ", [M, CharsSpacedFlattened]).

print_header(_, N):-
    format("  x | ", _),
    print_header(N).    
print_header(0).
print_header(N):-
    N0 is N - 1,
    print_header(N0),
    format("~d ", [N]). 

print_seperator(_, N):-
    format("~n  --+-", _),
    print_seperator(N).
print_seperator(0).
print_seperator(N):-
    N0 is N - 1,
    print_seperator(N0),
    format("~a", ['--']).

add_space(C, CS):-
    flatten(C, F),
    append(F, [' '], FS),
    atom_chars(A, FS),
    atom_chars(A, CS).       
    
main:-
    print_table(3, 3, _), nl, nl,
    print_table(3, 5, _),
    halt.
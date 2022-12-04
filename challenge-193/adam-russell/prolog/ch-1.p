binary --> [].
binary --> digit, binary.
digit  --> [0]; [1].

binary_numbers_size_n(N, BinaryNumbers):-
    length(Binary, N), 
    findall(Binary, phrase(binary, Binary), BinaryNumbers).

main:-
    binary_numbers_size_n(2, BinaryNumbers),
    write(BinaryNumbers), nl.
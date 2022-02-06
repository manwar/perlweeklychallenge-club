fibonacci_words(Size, A, B) --> {atom_concat(A, B, C), atom_chars(C, Chars), length(Chars, N), N < Size}, [A], fibonacci_words(Size, B, C).
fibonacci_words(Size, A, B) --> {atom_concat(A, B, C), atom_chars(C, Chars), length(Chars, N), N >= Size}, [C].

fibonacci_words_nth_character(A, B, N, NthChar) :-
    phrase(fibonacci_words(N, A, B), FibonacciWords),
    last(FibonacciWords, LongestTerm),
    atom_chars(LongestTerm, LongestTermChars),
    nth(N, LongestTermChars, NthChar).
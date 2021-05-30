:-initialization(main).   

next_palindrome(N, NextPalindrome):-
    current_prolog_flag(max_integer, MAX_INTEGER),
    N0 is N + 1, 
    between(N0, MAX_INTEGER, X),
    number_chars(X, C),
    reverse(C, R),
    number_chars(NR, R),
    NR == X,
    NextPalindrome = NR. 

main:-
    next_palindrome(1234, NextPalindrome0),
    write(NextPalindrome0), nl,
    next_palindrome(999, NextPalindrome1),
    write(NextPalindrome1), nl,
    halt.     

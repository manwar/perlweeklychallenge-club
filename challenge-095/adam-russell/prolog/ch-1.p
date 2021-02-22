/*
* Write a script to figure out if the given number is Palindrome. 
* Print 1 if true otherwise 0.
*/
:-initialization(main).

palindrome_even([]).  
palindrome_even([H|T]):-
    last(T, Last), 
    H == Last, 
    append(L, [Last], T), 
    palindrome_even(L).   

palindrome_odd([_|[]]).  
palindrome_odd([H|T]):-
    last(T, Last), 
    H == Last, 
    append(L, [Last], T), 
    palindrome_odd(L).   

palindrome(N):-
    current_prolog_flag(max_integer, MAX_INTEGER),
    between(1, MAX_INTEGER, N),
    number_chars(N, C), 
    length(C, Length), 
    M is Length mod 2,
    M == 0,
    palindrome_even(C).   
palindrome(N):-
    current_prolog_flag(max_integer, MAX_INTEGER),
    between(1, MAX_INTEGER, N),  
    number_chars(N, C), 
    length(C, Length), 
    M is Length mod 2,
    M == 1,
    palindrome_odd(C).  

is_palindrome(N):-
    palindrome(N),
    write(1), nl.
is_palindrome(N):-
    \+ palindrome(N),
    write(0), nl.

main:-
    is_palindrome(1221),
    is_palindrome(-101),
    is_palindrome(90),
    halt.  

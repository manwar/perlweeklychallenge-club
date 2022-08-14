cyclops(X):-
    number_chars(X, XChars),
    length(XChars, XCharsLength),
    XCharsLengthMinusOne is XCharsLength - 1,
    delete(XChars, '0', XCharsNoZero),
    length(XCharsNoZero, NoZeroLength),
    NoZeroLength == XCharsLengthMinusOne,
    append(Beginning, ['0'|End], XChars),
    length(Beginning, BeginningLength),
    length(End, EndLength),
    BeginningLength == EndLength.
  
palindrome(X):-
    number_codes(X, C),
    reverse(C, CR),
    number_codes(X, CR).

palindrome_prime(Prime):-
    current_prolog_flag(max_integer, MAX_INTEGER),
    between(100, MAX_INTEGER, Prime),
    palindrome(Prime),
    fd_prime(Prime).

palindromic_prime_cyclops(_) --> [].
palindromic_prime_cyclops(Seen) --> [X], {palindrome_prime(X), cyclops(X), \+ member(X, Seen)}, palindromic_prime_cyclops([X|Seen]).

main:-
    length(PalindromicPrimeCyclops, 5),
    phrase(palindromic_prime_cyclops([]), PalindromicPrimeCyclops),
    write(PalindromicPrimeCyclops), nl.
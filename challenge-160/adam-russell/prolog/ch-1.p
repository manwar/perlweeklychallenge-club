cardinal(1, one).
cardinal(2, two).
cardinal(3, three).
cardinal(4, four).
cardinal(5, five).
cardinal(6, six).
cardinal(7, seven).
cardinal(8, eight).
cardinal(9, nine).
cardinal(10, ten).

four_is_magic(N) --> {between(1, 9, N), \+N == 4, 
                      cardinal(N, Cardinal), 
                      atom_codes(Cardinal, Codes), 
                      length(Codes, Count)}, 
                      [N-Count], four_is_magic(Count).
four_is_magic(N) -->  {between(1, 9, N), N == 4}, [N-magic].

print_magic([]):-
    nl.
print_magic([H|T]):-
    N-Count = H,
    \+ N == 4,
    cardinal(N, Cardinal),
    cardinal(Count, CountCardinal), 
    format("~a is ~a, ", [Cardinal, CountCardinal]), 
    print_magic(T).
print_magic([H|T]):-
    N-_ = H,
    N == 4,
    cardinal(N, Cardinal),
    format("~a is ~a", [Cardinal, magic]), 
    print_magic(T).
                      
main(N) :-
    phrase(four_is_magic(N), FourIsMagic), 
    print_magic(FourIsMagic).                                           
                      
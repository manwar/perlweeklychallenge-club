:-initialization(first_5_pandigitals).

all_unique(_, []).
all_unique(L, [V|T]):-
    fd_exactly(1, L, V),
    all_unique(L, T).

pandigital(Pandigitals):-
    Digits = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
    Pandigitals = [A, B, C, D, E, F, G, H, I, J],
    fd_domain([A, B, C, D, E, F, G, H, I, J], Digits),
    A #= 1,
    B #= 0,
    all_unique([A, B, C, D, E, F, G, H, I, J], Digits),
    fd_labeling(Pandigitals).

first_5_pandigitals:-
    setof(P, pandigital(P), Pandigitals),
    sort(Pandigitals, [A, B, C, D, E | _ ]),
    print_pandigitals([A, B, C, D, E]).

print_pandigitals([]).
print_pandigitals([H|T]):-
    maplist(number_codes, H, Codes), 
    flatten(Codes, DigitCodes), 
    number_codes(Number, DigitCodes),
    write(Number), nl,
    print_pandigitals(T).
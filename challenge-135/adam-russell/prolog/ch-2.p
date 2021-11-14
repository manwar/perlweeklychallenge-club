:-initialization(main).

weight(1, 1).
weight(2, 3).
weight(3, 1).
weight(4, 7).
weight(5, 3).
weight(6, 9).

base --> alphanumeric, alphanumeric, alphanumeric, alphanumeric, alphanumeric, alphanumeric.
alphanumeric --> [AlphaNumeric], {letter_or_digit(AlphaNumeric)}.

sedol(Sedol):-
    var(Sedol),
    sedol(_, Sedol).
sedol(Sedol):-
    nonvar(Sedol),
    length(Base, 6),
    append(Base, [CheckDigit], Sedol),
    phrase(base, Base),
    compute_check(Base, ComputedCheckDigit),
    CheckDigit == ComputedCheckDigit.
    
sedol(Base, Sedol):-
    phrase(base, Base),
    check_digit(Base, Sedol).

letter_or_digit(A):-
    nonvar(A),
    atom_codes(A, C),
    ((C >= 66, C =< 90);
     (C >= 48, C =< 57)).

letter_or_digit(A):-
    var(A),
    ((between(66, 90, C));  %B through Z
     (between(48, 57, C))), %0-9
    atom_codes(A, [C]).

compute_check(Base, CheckSum):-
    compute_check(Base, 1, CheckSum, 0).
compute_check([], _, CheckSum, PartialCheckSum):-
    CheckSum is mod(10 - mod(PartialCheckSum, 10), 10).    
compute_check([H|T], Index, CheckSum, PartialCheckSum):-
    atom_codes(H, [C]),
    between(66, 90, C),
    weight(Index, Weight),
    LetterValue is C - 64 + 9,
    Partial is PartialCheckSum + (LetterValue * Weight),
    succ(Index, I),
    compute_check(T, I, CheckSum, Partial).
compute_check([H|T], Index, CheckSum, PartialCheckSum):-
    atom_codes(H, [C]),
    between(48, 57, C),
    weight(Index, Weight),
    NumeralValue is C - 48,
    Partial is PartialCheckSum + (NumeralValue * Weight),
    succ(Index, I),
    compute_check(T, I, CheckSum, Partial).
    
check_digit(Base, BaseCheckDigit):-
    compute_check(Base, CheckDigit),
    append(Base, [CheckDigit], BaseCheckDigit).       


main:-
    (sedol(['2','9','3','6','9','2',1]), format("1~n", _);
     format("0~n", _)),
    (sedol(['1','2','3','4','5','6',7]), format("1~n", _);
     format("0~n", _)),
    (sedol(['B','0','Y','B','K','L',9]), format("1~n", _);
     format("0~n", _)),
    halt.
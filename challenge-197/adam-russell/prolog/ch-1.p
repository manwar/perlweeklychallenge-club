zeroes --> [].
zeroes --> zero, [].
zeroes --> zero, zeroes, zero.
zeroes_end --> digit, zeroes.
zeroes_end --> digit, zeroes_end, zeroes.
digit --> [], [1]; [2]; [3]; [4]; [5]; [6]; [7]; [8]; [9].
zero --> [0].

zeroes_at_end(Numbers, ZeroesEnd):-
    length(Numbers, NumbersLength), 
    delete(Numbers, 0, NumbersZeroDeleted), 
    length(NumbersZeroDeleted, NumbersZeroDeletedLength), 
    X is NumbersLength - NumbersZeroDeletedLength, 
    length(End, X), 
    append(NumbersZeroDeleted, End, ZeroesEnd), 
    phrase(zeroes_end, ZeroesEnd), !.

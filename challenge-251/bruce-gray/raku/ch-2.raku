sub task2 ( @in --> Numeric ) {
    # Prevents recalculation inside `.first`
    my @column_maxes = @in[0].keys.map({ @in».[$_].max });

    for @in -> @row {
        return .value with @row.minpairs.first: { @column_maxes[.key] == .value };
    }
    return -1;
}


my @tests =
    ( 15, ( ( 3,  7,  8    ), ( 9, 11, 13    ), (15, 16, 17    ) ) ),
    ( 12, ( ( 1, 10,  4,  2), ( 9,  3,  8,  7), (15, 16, 17, 12) ) ),
    (  7, ( ( 7,  8        ), ( 1,  2        )                   ) ),

    (  3, ( ( 3,  3,  3    ), ( 3,  9,  9    ), ( 3, 3, 3    ) ) ),
    
    (  3, ( ( 9,  3, 15    ), ( 9,  3, 15    ), ( 9, 3, 15    ) ) ),

    ( -1, ( ( 1, 5, 8 ), ( 2, 6, 4 ), ( 7, 3, 9 ) ) ),

    ( -1, ( (0, 1, 2), (1, 2, 0), (2, 0, 1) ) ),
;
use Test; plan +@tests;
for @tests -> ( $expected, @in ) {
    is task2(@in), $expected;
}

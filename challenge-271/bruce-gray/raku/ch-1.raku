sub task1 ( @matrix --> UInt ) {
    return 1 + @matrix».sum.maxpairs.head.key;
}


use Test; plan +constant @tests1 =
    ( 1, ( (0, 1), (1, 0) ) ),
    ( 2, ( (0, 0, 0), (1, 0, 1) ) ),
    ( 2, ( (0, 0), (1, 1), (0, 0) ) ),
;
for @tests1 -> ($expected, @matrix) {
    is task1(@matrix), $expected, "@matrix[]";
}

sub task2 ( @ns ) {
    return @ns.map({ $_, (0 if .not) }).flat.head(+@ns);
}


my @tests =
    ( (1, 0, 2, 3, 0, 4, 5, 0) , (1, 0, 0, 2, 3, 0, 0, 4) ),
    ( (1, 2, 3)                , (1, 2, 3) ),
    ( (0, 3, 0, 4, 5)          , (0, 0, 3, 0, 0) ),
;
use Test; plan +@tests;
for @tests ->     ( @in , @expected ) {
    is-deeply task2(@in), @expected;
}

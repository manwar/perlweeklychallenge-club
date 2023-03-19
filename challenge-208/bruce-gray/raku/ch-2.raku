sub task2 ( @ns --> List ) {
    my @repeated = @ns.repeated;
    my @missing  = ( (1 .. +@ns) (^) @ns ).keys.sort(+*);

    return ( @repeated == 1 and @missing == 1 )
        ?? ( @repeated.head,    @missing.head )
        !! Nil;
}


constant @tests =
    ( (1,2,2,4) , (2,3) ),
    ( (1,2,3,4) , -1    ),
    ( (1,2,3,3) , (3,4) ),
;
use Test;
plan +@tests;
for @tests -> ( $in, $expected ) {
    is-deeply (task2($in) // -1), $expected;
}

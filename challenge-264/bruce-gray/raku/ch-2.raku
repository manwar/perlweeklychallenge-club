sub task2 ( @source, @indices ) {
    my @r;
    @r.splice(.[0], 0, .[1]) for @indices Z @source;
    return @r;
}


my @tests =
    ( (0, 1, 2, 3, 4), (0, 1, 2, 2, 1), (0, 4, 1, 3, 2) ),
    ( (1, 2, 3, 4, 0), (0, 1, 2, 3, 0), (0, 1, 2, 3, 4) ),
    ( (1,)           , (0,)           , (1,)            ),
;
use Test; plan +@tests;
for @tests -> ( @source, @indices, @expected ) {
    is-deeply task2(@source, @indices), @expected.Array;
}

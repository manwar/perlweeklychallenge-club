# Using empty Seq instead of -1 when nothing is selected.
sub task1 ( @ns --> Seq ) {
    my $min_and_max = @ns.minmax.bounds.any;

    return @ns.grep: * != $min_and_max;
}


my @tests =
    ( (3, 2, 1, 4), (3, 2) ),
    ( (3, 1),       ()     ),
    ( (2, 1, 3),    (2,)   ),
;
use Test;
plan +@tests;
for @tests -> ( @in, @expected ) {
    is-deeply task1(@in), @expected;
}

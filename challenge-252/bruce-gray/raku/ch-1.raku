sub sum_of_squares ( @a --> UInt ) { @a»².sum }

sub special_elements ( @a ) {
    # An array element is "special" if its 1-based index
    # evenly divides into the array size.
    return @a.grep({ @a %% ++$ });
}

sub task1 ( @ns --> UInt ) {
    return sum_of_squares special_elements @ns;
}


my @tests =
    ( 21, (1, 2, 3, 4) ),
    ( 63, (2, 7, 1, 19, 18, 3) ),
;
use Test; plan +@tests;
for @tests -> ( $expected, @in ) {
    is task1(@in), $expected;
}

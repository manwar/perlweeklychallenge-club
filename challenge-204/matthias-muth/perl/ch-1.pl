#!/usr/bin/env perl

use List::Util qw( reduce );

sub monotonic {
    return 1
        if reduce { ( defined $a && $a <= $b ) ? $b : undef } @_
        or reduce { ( defined $a && $a >= $b ) ? $b : undef } @_;
    return 0;
}

use Test::More;

is monotonic( 1, 2, 2, 3 ), 1, "monotonic( 1, 2, 2, 3 ) == 1";
is monotonic( 1, 3, 2 ),    0, "monotonic( 1, 3, 2 )    == 0";
is monotonic( 6, 5, 5, 4 ), 1, "monotonic( 6, 5, 5, 4 ) == 1";

done_testing;

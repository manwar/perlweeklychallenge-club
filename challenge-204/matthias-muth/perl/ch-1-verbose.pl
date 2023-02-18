#!/usr/bin/env perl

use feature qw( say );

use Data::Dump qw( pp );
use List::Util qw( reduce );

sub monotonic {
    say "monotonic( @_ )";
    return 1
        if reduce {
            my $result = ( defined $a && $a <= $b ) ? $b : undef;
            say "comparing ", pp( $a ), " <= ", pp( $b ), ": ", pp( $result );
            $result;
        } @_
        or reduce {
            my $result = ( defined $a && $a >= $b ) ? $b : undef;
            say "comparing ", pp( $a ), " >= ", pp( $b ), ": ", pp( $result );
            $result;
        } @_;
    return 0;
}

use Test::More;

is monotonic( 1, 2, 2, 3 ), 1, "monotonic( 1, 2, 2, 3 ) == 1";
is monotonic( 1, 3, 2 ),    0, "monotonic( 1, 3, 2 )    == 0";
is monotonic( 6, 5, 5, 4 ), 1, "monotonic( 6, 5, 5, 4 ) == 1";
done_testing;

use strict;
use warnings;

use Test::More tests => 4;

is( max_gap( 2, 9, 3, 5 ),    4, "example 1" );
is( max_gap( 1, 3, 8, 2, 0 ), 5, "example 2" );
is( max_gap(5),               0, "example 3" );
is( max_gap( -3, 4, 2, 6 ),   5, "negative numbers" );

sub max_gap {
    my @N       = @_;
    my $max_gap = 0;
    my $gap     = undef;
    my $prev    = undef;

    return 0 if ( scalar(@N) == 1 );

    foreach my $s ( sort @N ) {
        if ( defined($prev) ) {
            $gap     = $s - $prev;
            $max_gap = $gap if ( $gap > $max_gap );
            $prev    = $s;
        }
        else {    # first run
            $prev = $s;
        }
    }

    return $max_gap;
}

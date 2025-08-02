use strict;
use warnings;

use v5.38;

sub digit_count_check( @ints ) {
    my @counts = @ints;
    grep { return 0 unless --$counts[ $_ ] >= 0 } @ints;
    grep { return 0 unless !$_ } @counts; 
    return 1;
}

my @inputs = (
    [1, 2, 1, 0],
    [0, 3, 0],
    [3, 3, 1],
    [3, 2, 4, 2, 4],
    [1],
    [1, 2, 3, 4],
    [1, 1, 2, 2, 3, 3, 4, 4],
    );
for (@inputs) {
    say join( ", ", @$_ ) . ' => ' . ( digit_count_check( @$_ ) ? 'true' : 'false' );
}


use strict;
use warnings;

use v5.38;

sub find_one_unique( @ints ) {
    my %counts;
    grep { ++$counts{ $_ } } @ints;
    my @singletons = grep { $counts{ $_ } == 1 } keys %counts;
    return $singletons[0];
}

my @inputs = (
    [3, 3, 1],
    [3, 2, 4, 2, 4],
    [1],
    [1, 2, 3, 4],
    [1, 1, 2, 2, 3, 3, 4, 4],
    );
for (@inputs) {
    say join( ", ", @$_ ) . ' => ' . find_one_unique( @$_ );
}


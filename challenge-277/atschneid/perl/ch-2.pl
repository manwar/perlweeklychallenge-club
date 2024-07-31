use strict;
use warnings;

use v5.38;

my @inputs = (
    [1, 2, 3, 4, 5],
    [5, 7, 1, 7]
    );
for (@inputs) {
    say join (", ", @$_) . " :: " . count_strong_pairs( @$_ );
}

sub count_strong_pairs ( @ints ){
    my %counts;
    my @arr = sort grep { ++$counts{ $_ } == 1 } @ints;

    my $strong_count = 0;
    for my $i (0..$#arr) {
	for my $j ($i+1..$#arr) {
	    if ( $arr[$j] >= 2 * $arr[$i] ) {
		last;
	    }
	    ++$strong_count;
	}
    }
	       
    return $strong_count;
}


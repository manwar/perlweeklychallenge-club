use warnings;
use strict;

use v5.38;

use List::Util qw( max );

sub find_highest_lucky_num( @ints ) {
    my %counts;
    grep { ++$counts{ $_ } } @ints;
    my @lucky_nums = grep { $counts{ $_ } == $_ } keys %counts;
    if ( @lucky_nums ) {
	return max @lucky_nums;
    }
    return -1;
}

my @inputs = (
    [2, 2, 3, 4],
    [1, 2, 2, 3, 3, 3],
    [1, 1, 1, 3],
    );
for (@inputs) {
    say join ( ', ', @$_ ) . ' => ' . join ( ', ', find_highest_lucky_num( @$_ ) );
}

use warnings;
use strict;

use v5.38;

use List::Util qw( min max );

sub find_min_max( @arr ) {
    my $counter = 0;
    while ( $#arr > 0 ) {
	my @new_arr;
	for (my $idx = 1; $idx <= $#arr; $idx += 2) {
	    push @new_arr, ( $counter % 2 ) ?
		max( $arr[$idx], $arr[$idx-1] ) :
		min( $arr[$idx], $arr[$idx-1] );
	    ++$counter;
	}
	@arr = @new_arr;
    }
    return $arr[0];
}

my @inputs = (
    [2, 1, 4, 5, 6, 3, 0, 2],
    [0, 5, 3, 2],
    [9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8],
    );
for (@inputs) {
    say ( join ', ', @$_ );
    say ' => ' . find_min_max( @$_ );
}

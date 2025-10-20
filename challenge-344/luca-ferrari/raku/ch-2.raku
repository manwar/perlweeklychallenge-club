#!raku

#
# Perl Weekly Challenge 344
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-344>
#

sub MAIN( ) {
    my @source = [2,3], [1], [4];
    my @destination = 1,2,3,4;

    #@source = [9,1], [5,8], [2];
    #@destination = 5, 8, 2, 9, 1;

    # @source = [1], [3];
    # @destination = 1,2,3;

    my $destination-as-string = @destination.sort.join;

    my $found = 0;
    for @source -> $current {
	my $index = Nil;

	for $current.List -> $x {
	    'False'.say and exit if ( ! @destination.grep( * ~~ $x ) );
	    if ( ! $index ) {
		$index = @destination.grep( * ~~ $x, :k ).first;
	    }
	    else {
		'False'.say and exit if ( @destination[ ++$index ] != $x );
	    }

	    $found++;
	}
    }



    'True'.say and exit if ( $found == @destination.elems );
    'False'.say;
}

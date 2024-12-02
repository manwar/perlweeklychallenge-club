#!raku

#
# Perl Weekly Challenge 298
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-298>
#



sub MAIN() {
    my @intervals = [ 3, 4 ],
		    [ 2, 3 ],
		    [ 1, 2 ];

    my @right;

    for 0 ..^ @intervals.elems -> $current {
	my %found;

	for 0 ..^ @intervals.elems -> $next {
	    next if ( @intervals[ $current ][ 0 ] == @intervals[ $next ][ 0 ]
						      && @intervals[ $current ][ 1 ] == @intervals[ $next ][ 1 ] );

	    %found{ @intervals[ $next ][ 0 ] }.push: $next if ( @intervals[ $next ][ 0 ] >= @intervals[ $current ][ 1 ] );
	}

	@right.push: -1 and next if ( ! %found );
	@right.push: %found{ %found.keys.min };
    }

    @right.join( ',' ).say;
}

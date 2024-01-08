#!raku

#
# Perl Weekly Challenge 251
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-251/>
#

sub MAIN() {

    my $matrix = [ [ 3,  7,  8],
                   [ 9, 11, 13],
                   [15, 16, 17] ];

    my @max-col;
    for 0 ..^ $matrix[ 0 ].elems -> $col {
	my @current-col.push: $matrix[ $_ ][ $col ] for 0 ..^ $matrix.elems;
	@max-col[ $col ] = @current-col.max;
    }

    for 0 ..^ $matrix.elems -> $row {
	my $min = Nil;
	my $min-col = Nil;

	for 0 ..^ $matrix[ $row ].elems -> $col {
	    if ( ! $min ||  $matrix[ $row ][ $col ] < $min ) {
		$min-col = $col;
		$min = $matrix[ $row ][ $col ];
	    }
	}

	$min.say and exit if ( @max-col[ $min-col ] == $min );
    }

    '-1'.say;
}

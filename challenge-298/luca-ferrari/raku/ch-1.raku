#!raku

#
# Perl Weekly Challenge 298
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-298>
#

sub MAIN() {

    my  @matrix = [1, 0, 1, 0, 0],
                  [1, 0, 1, 1, 1],
                  [1, 1, 1, 1, 1],
                  [1, 0, 0, 1, 0];

    my @sizes;

    for 0 ..^ @matrix.elems  -> $row {
	for 0 ..^ @matrix[ $row ].elems  -> $col {
	    next if @matrix[ $row ][ $col ] != 1;

	    my $size = 1;
	    my $found = True;

	    while ( $found ) {
		if ( $col + $size >= @matrix[ $row ].elems || $row + $size >= @matrix.elems ) {
		    $found = False;
		    $size--;
		    last;
		}

		if ( @matrix[ $row .. $row + $size ][ $col .. $col + $size ].grep( * !~~ 1 ) ) {
		    $found = False;
		    $size = $size - 1;
		    last;
		}
		else {
		    $size++;
		}
	    }

	    @sizes.push: $size;
	}
    }

    @sizes.max.say;

}

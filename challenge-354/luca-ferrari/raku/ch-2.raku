#!raku

#
# Perl Weekly Challenge 354
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-354>
#

sub MAIN() {
    my @matrix = [1, 2, 3],
                 [4, 5, 6],
                 [7, 8, 9];
    my $k = 1;

    @matrix = [1, 2],
                  [3, 4],
                  [5, 6];
    $k = 1;

    @matrix = [1, 2, 3],
              [4, 5, 6];
    $k = 5;

    my @next;
    while ( $k ) {
	for 0 ..^ @matrix.elems -> $row {
	    if ( $row == 0 ) {
		@next[ $row ].push: @matrix[ * - 1 ][ * - 1 ];  # element at 0, 0
		@next[ $row ].push: |@matrix[ $row ][ 0 .. * - 2 ]; # first row
	    }
	    else {
		@next[ $row ].push: @matrix[ $row - 1 ][ * - 1 ];
		@next[ $row ].push: |@matrix[ $row  ][ 0 .. * - 2 ];
	    }
	}

	$k--;
	if ( $k ) {
	    @matrix = @next;
	    @next = ();
	}
    }


    say @next;
}

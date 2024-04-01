#!raku

#
# Perl Weekly Challenge 257
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-257>
#

sub MAIN() {
# 1. If a row does not consist entirely of zeros, then the first
#    nonzero number in the row is a 1. We call this the leading 1.
# 2. If there are any rows that consist entirely of zeros, then
#    they are grouped together at the bottom of the matrix.
# 3. In any two successive rows that do not consist entirely of zeros,
#    the leading 1 in the lower row occurs farther to the right than
#    the leading 1 in the higher row.
# 4. Each column that contains a leading 1 has zeros everywhere else
    #    in that column.

    my $M = [
        [1, 1, 0],
        [0, 1, 0],
        [0, 0, 0]
    ];

    # $M = [
    #     [0, 1,-2, 0, 1],
    #     [0, 0, 0, 1, 3],
    #     [0, 0, 0, 0, 0],
    #     [0, 0, 0, 0, 0]
    # ];

    # $M = [
    #               [0, 1,-2, 0, 1],
    #               [0, 0, 0, 0, 0],
    #               [0, 0, 0, 1, 3],
    #               [0, 0, 0, 0, 0]
    # ];

    # $M = [
    #               [1, 0, 0, 4],
    #               [0, 1, 0, 7],
    #               [0, 0, 1,-1]
    #             ];
    my $ok = True;
    my @zero-rows;
    my @leadings;
    for 0 ..^ $M.elems -> $row {
	my $first-in-row = Nil;


	for 0 ..^ $M[ $row ].elems -> $col {
	    next if $M[ $row ][ $col ] == 0;
	    next if $first-in-row;

	    $first-in-row = $M[ $row ][ $col ] if ! $first-in-row;

	    if ( $first-in-row == 1 ) {
		# leading one
		@leadings.push: { row => $row, col => $col };
		# if not other leadings, skip any check
		next if @leadings.elems <= 1;

		$ok = False and last if ( @leadings[ * - 2 ]<col> >= $col && @leadings[ * - 2 ]<row> != ( $row - 1 ) );
	    }
	}

	if ! $first-in-row {
	    # the row was made by all zeros
	    @zero-rows.push: $row;
	    # if this is the first zero row, cannot check anything
	    next if @zero-rows.elems <= 1;
	    # this is not the first zero row, so the previous row must be also zero!
	    $ok = False if @zero-rows[ * - 2 ] != ( $row - 1 );
	}
	elsif $first-in-row != 1 {
	    $ok = False;
	}

	'0'.say and exit if ( ! $ok );
    }

    '1'.say; # here everything is fine
}

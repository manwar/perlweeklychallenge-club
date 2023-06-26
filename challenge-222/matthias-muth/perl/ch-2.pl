#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 222 Task 2: Last Member
#
#       Perl solution by Matthias Muth.
#

use strict;
use warnings;
use feature qw( say );

use lib '.';
use TestExtractor;

sub last_member {
    my @ints = @_;

    while ( @ints >= 2 ) {
	# Sort the array, largest first.
	@ints = sort { $b <=> $a } @ints;

	# Get the difference between the first two elements
        # (it will be non-negative because the first element is the largest).
	my $diff = $ints[0] - $ints[1];

	# Replace the first two entries by their difference,
	# or by nothing if the difference is zero.
	splice @ints, 0, 2, $diff || ();
    }
    return $ints[0] // 0;
}

run_tests;

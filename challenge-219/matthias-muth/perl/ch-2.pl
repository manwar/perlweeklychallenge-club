#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 219 Task 2: Travel Expenditure
#
#       Perl solution by Matthias Muth.
#

use strict;
use warnings;
use feature 'say';

use lib '.';
use TestExtractor;

use List::Util qw( min );

my @durations = ( 1, 7, 30 );

sub travel_expenditure {
    my ( $costs, $days ) = @_;
    return 0
        if @$days == 0;
    return min(
        map {
	    my $duration = $durations[$_];
	    $costs->[$_]
		+ travel_expenditure( $costs,
		    [ grep $_ >= $days->[0] + $duration, @$days ] );
	} 0..$#{$costs}
    );
}

run_tests;

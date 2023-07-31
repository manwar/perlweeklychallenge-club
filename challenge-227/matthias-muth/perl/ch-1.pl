#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 227 Task 1: Friday 13th
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use lib '.';
use TestExtractor;

use Time::Local;
use Time::Piece;

sub friday_13th_a( $year ) {
    return scalar grep {
        Time::Piece->strptime( "$year-$_-13", "%Y-%m-%d" )->day_of_week == 5
    } 1..12;
}

sub friday_13th_d( $year ) {
    return scalar grep {
	gmtime( timegm( 0, 0, 0, 13, $_ - 1, $year - 1900 ) )->day_of_week == 5
    } 1..12;
}

sub friday_13th( $year ) {
    return friday_13th_a( $year );
    # return friday_13th_b( $year );
}

run_tests;

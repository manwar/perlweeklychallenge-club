#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use Date::Calc 'Day_of_Week';

sub main ($year) {
    my $fridays = 0;
    foreach my $month ( 1 .. 12 ) {
        if ( Day_of_Week( $year, $month, 13 ) == 5 ) {
            $fridays++;
        }
    }

    say $fridays;
}

main(@ARGV);
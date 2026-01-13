#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main ($results) {
    if ( $results !~ /^[HA]{6}$/ ) {
        die
          "Input must be a string of exactly six characters, each either 'H' or 'A'.\n";
    }

    # Calculate week one winners, and teams playing in week two
    my @week_two = sort { $a <=> $b } (
        1,
        substr( $results, 0, 1 ) eq 'H' ? 2 : 7,
        substr( $results, 1, 1 ) eq 'H' ? 3 : 6,
        substr( $results, 2, 1 ) eq 'H' ? 4 : 5
    );

    # Calculate week two winners, and teams playing in the final
    my @week_three = sort { $a <=> $b } (
        substr( $results, 3, 1 ) eq 'H' ? $week_two[0] : $week_two[3],
        substr( $results, 4, 1 ) eq 'H' ? $week_two[1] : $week_two[2]
    );

    if ( substr( $results, 5, 1 ) eq "A" ) {
        # The away team won, so we need to reverse the order
        @week_three = reverse(@week_three);
    }

    say "Team $week_three[0] defeated Team $week_three[1]";
}

main( $ARGV[0] );

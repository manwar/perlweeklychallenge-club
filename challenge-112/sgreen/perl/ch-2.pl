#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub _climb {
    my ( $remaining, $this_climb, $climbs ) = @_;
    if ( $remaining == 1 ) {
        # Add the last step to the list of climbs
        push @$climbs, [ @$this_climb, 1 ];
    }
    elsif ( $remaining == 2 ) {
        # Add the two possible ways to climb two slips to the list
        #  of climbs
        push @$climbs, [ @$this_climb, 1, 1 ];
        push @$climbs, [ @$this_climb, 2 ];
    }
    else {
        # Call the recursive function again
        _climb( $remaining - 1, [ @$this_climb, 1 ], $climbs );
        _climb( $remaining - 2, [ @$this_climb, 2 ], $climbs );
    }
}

sub main {
    my $steps  = shift;
    my @climbs = ();

    # Call a recursive function to calculate the steps
    _climb( $steps, [], \@climbs );

    # Display the number of solutions
    say "Output: ", scalar(@climbs);
    say '';

    # Display the options
    my $idx = 0;
    foreach my $steps (@climbs) {
        ++$idx;
        say "Option $idx: ", join ' + ', map { $_ == 1 ? '1 step' : '2 steps' } @$steps;
    }
}

main(@ARGV);

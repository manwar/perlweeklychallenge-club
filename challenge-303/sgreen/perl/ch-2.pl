#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub score($freq) {
    my $max_points = undef;

    # Work through each frequency.
    foreach my $i ( keys %$freq ) {
        # Start with the points for using this integers.
        my $points = $i;

        # Delete the frequency one less and one more than `i`.
        my $new_freq = {%$freq};
        delete $new_freq->{ $i - 1 };
        delete $new_freq->{ $i + 1 };

        # Also remove one from this frequency, and delete if it is now zero.
        $new_freq->{$i} -= 1;
        if ( $new_freq->{$i} == 0 ) {
            delete $new_freq->{$i};
        }

        # If there is something left, call the function again.
        if (%$new_freq) {
            $points += score($new_freq);
        }

        # Update max_points if required.
        if ( not defined $max_points or $max_points < $points ) {
            $max_points = $points;
        }
    }

    return $max_points;
}

sub main (@ints) {
    # Turn the list into a frequency dictionary and find the maximum points
    my %freq = ();
    foreach my $i (@ints) {
        $freq{$i}++;
    }

    say score( \%freq );
}

main(@ARGV);
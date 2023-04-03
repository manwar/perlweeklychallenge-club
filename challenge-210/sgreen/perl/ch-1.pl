#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util qw(sum uniq);

sub main(@array) {
    my $score = 0;

    # Get all unique numbers
    foreach my $i (uniq(@array)) {
        # Calculate the sum of all numbers one less, the same or one more
        #  than the target
        my $this_score = sum( grep { $_ >= $i-1 and $_ <= $i+1} @array);

        # Record this score if it is larger
        if ($score < $this_score) {
            $score = $this_score;
        }
    }

    say $score;
}

main(@ARGV);
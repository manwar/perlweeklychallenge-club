#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my @numbers = @_;

    # Sanity check
    die "You must enter one or more non-negative integers\n"
      unless scalar(@numbers);
    foreach (@numbers) {
        die "The value '$_' doesn't appear to be a non-negative integer\n"
          unless /^[0-9][0-9]*$/;
    }

    my $position = 0;
    my $target   = $#numbers;

    while (1) {
        if ( $position == $target ) {
            # We've reached the target
            return 1;
        }
        elsif ( $position > $target ) {
            # We've gone to far. No solution is possible
            return 0;
        }
        elsif ( $numbers[$position] == 0 ) {
            # We're going nowhere. No solution is possible
            return 0;
        }

        # Move forward by the position in this value
        $position += $numbers[$position];
    }
}

say main(@ARGV);

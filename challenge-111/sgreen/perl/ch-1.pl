#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my $target = pop;
    my @matrix = ( join( ' ', @_ ) =~ /(\d+)/g );

    my $low    = 0;
    my $high   = $#matrix;
    my $checks = 0;
    my $found  = 0;

    while (1) {
        ++$checks;

        # Find the middle value (round down if not even)
        my $index = int( ( $low + $high ) / 2 );
        my $value = $matrix[$index];

        if ( $matrix[$index] == $target ) {
            # We've found the target number
            $found = 1;
            last;
        }
        elsif ( $low >= $high ) {
            # The number doesn't exist
            last;
        }
        elsif ( $value > $target ) {
            $high = $index - 1;
        }
        else {
            $low = $index + 1;
        }

    }

    say "Answer is $found, in $checks check(s)";
}

main(@ARGV);

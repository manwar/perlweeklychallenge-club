#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util qw(max sum);

sub main (@ints) {
    # The last two values are $x and $y
    my $y     = pop(@ints);
    my $x     = pop(@ints);
    my $score = 0;

    # Calculate the needed values
    my $max_value = max(@ints);
    my @needed    = map { $max_value - $_ } @ints;

    # If we have at least two items, and y is less than 2 × x, lets remove two
    #  values at a time while we can
    if ( $#ints > 0 and $y < $x * 2 ) {
        while (1) {
            # Sort the positions by the values they hold
            my @sorted_index =
              sort { $needed[$b] <=> $needed[$a] } ( 0 .. $#ints );

            # If we don't have two non zero values, ww are done with level 2
            if ( $needed[ $sorted_index[1] ] == 0 ) {
                last;
            }

            # Take one off each number at that position
            $needed[ $sorted_index[0] ] -= 1;
            $needed[ $sorted_index[1] ] -= 1;
            $score                      += $y;
        }
    }

    # As level one takes one off each number, we simply multiple the remaining
    #  needed values by the x value
    $score += sum(@needed) * $x;

    say $score;
}

main(@ARGV);
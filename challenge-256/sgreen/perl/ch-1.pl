#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'any';

sub main (@words) {
    my $count = 0;

    while (@words) {
        # Take one word from the list
        my $word = pop(@words);

        # See if the reverse of it is also in the list
        if (any { $_ eq reverse($word) } @words) {
            $count++;
        }
    }

    # Return the number of pairs
    say $count;
}

main(@ARGV);
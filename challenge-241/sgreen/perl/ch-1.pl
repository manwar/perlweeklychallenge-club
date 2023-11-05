#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@ints) {
    # The last value is the diff
    my $diff = pop(@ints);

    # To make life easier, convert the ints into a hash
    my %ints = map { $_, 1 } @ints;

    # Even though the task says the array is sorted, let's do it anyway
    @ints = sort { $a <=> $b } @ints;
    my $count = 0;

    foreach my $i (@ints) {
        # Check the the next two values are in the hash
        if ( $ints{ $i + $diff } and $ints{ $i + $diff * 2 } ) {
            $count++;
        }
    }

    say $count;
}

main(@ARGV);
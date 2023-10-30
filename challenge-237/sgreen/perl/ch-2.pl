#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util qw(min max);
use List::MoreUtils 'firstidx';

sub main (@ints) {
    my @sorted_ints = sort { $b <=> $a } @ints;
    my $count = 0;

    foreach my $i (@sorted_ints) {
        # If there isn't a solution, exit the loop
        if (min(@ints) >= $i) {
            last;
        }

        # Find the position of the maximum value < i, and delete it
        my $m = max(grep {$_ < $i} @ints);
        my $idx = firstidx { $_ == $m } @ints;
        splice(@ints, $idx, 1);

        ++$count;
    }
    
    say $count;
}

main(@ARGV);
#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'min';

sub main (@ints) {
    # Calculate frequency of the integers
    my %freq = ();
    foreach my $i (@ints) {
        $freq{$i}++;
    }

    # Calculate 33% of the number of items
    my $percent_33 = 0.33 * scalar(@ints);

    # Return the minimum value that appears more than 33% of the time
    my @int_list = sort { $a <=> $b } keys %freq;
    foreach my $i (@int_list) {
        if ($freq{$i} > $percent_33) {
            say $i;
            return;
        }
    }

    say undef;
}

main(@ARGV);
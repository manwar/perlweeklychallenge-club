#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'sum';
use Algorithm::Combinatorics 'combinations';

sub main(@n) {
    # Calculate average
    my $avg = sum(@n) / scalar(@n);

    # A single element is always true
    if ($#n == 0) {
        say 'true';
        return;
    }


    # Consider combination of size 1 to half the length
    foreach my $i (1 .. scalar(@n)/2) {
        # Work through each combination
        my $iter = combinations(\@n, $i);
        while ( my $c = $iter->next ) {
            # If combination average is same, the remaining items also will be
            if (sum(@$c) / $i == $avg) {
                say 'true';
                return;
            }
        }
    }

    say 'false';
}

main(@ARGV);
#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::MoreUtils 'first_index';

sub main (@ints) {
    my @missing = ();
    for my $i (1 .. scalar(@ints)) {
        if ((first_index { $_ == $i } @ints) == -1) {
            push @missing, $i;
        }
    }

    say '(' . join(', ', @missing) . ')';
}

main(@ARGV);
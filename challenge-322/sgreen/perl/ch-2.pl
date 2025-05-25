#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::MoreUtils 'first_index';
use List::Util 'uniq';

sub main (@ints) {
    # Generate a list of the sorted unique values.
    my @sorted_array = sort { $a <=> $b } uniq(@ints);
    my @solution     = ();

    foreach my $int (@ints) {
        # Return the position (1-based) of the each value.
        my $idx = first_index { $_ == $int } @sorted_array;
        push @solution, $idx + 1;
    }

    say '(', join( ', ', @solution ), ')';
}

main(@ARGV);

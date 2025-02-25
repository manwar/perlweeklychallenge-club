#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'none';

sub main (@ints) {
    my $longest_set = 0;

    foreach my $start ( 0 .. $#ints ) {
        # Keep track of items we've used
        my @this_set = ( $ints[$start] );

        # Keep adding to the set until we we hit an already used number
        while ( none { $_ == $ints[ $this_set[-1] ] } @this_set ) {
            push @this_set, $ints[ $this_set[-1] ];
        }

        # If the set is longer than previous ones found, update it.
        if ( $longest_set < scalar(@this_set) ) {
            $longest_set = scalar(@this_set);
        }
    }

    say $longest_set;
}

main(@ARGV);
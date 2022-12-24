#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';
use List::Util qw(max min);

sub main (@list) {
    # Count the frequency of even numbers
    my %evens = ();
    foreach my $i (@list) {
        $evens{$i}++ if $i % 2 == 0;
    }

    if ( scalar keys(%evens) == 0 ) {
        # If no evens, return -1
        say -1;
    }
    else {
        # Find the evens that occur most often
        my $m         = max( values(%evens) );
        my @max_evens = grep { $evens{$_} == $m } keys(%evens);

        # The the minimum even that occurs most often
        my $min_max_evens = min(@max_evens);
        say $min_max_evens;
    }
}

main(@ARGV);
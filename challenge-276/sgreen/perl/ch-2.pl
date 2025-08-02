#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util qw(max);

sub main (@ints) {
    # Convert the list in a frequency dictionary
    my %freq = ();
    foreach my $i (@ints) {
        $freq{$i}++;
    }

    my $max_freq = max( values(%freq) );

    # Count the number of elements with the maximum frequency
    my $elements = grep { $freq{$_} == $max_freq } keys(%freq);

    # Multiply the number of elements by the frequency
    say $elements * $max_freq;
}

main(@ARGV);
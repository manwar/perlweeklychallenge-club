#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@ints) {
    # Calculate the frequency of all integers
    my %freq = ();
    foreach my $i (@ints) {
        ++$freq{$i};
    }

    # Sort the integers in descending order, and then by the frequency
    my @sorted_ints = sort { $freq{$a} <=> $freq{$b} || $b <=> $a } keys %freq;

    # The solution has the frequency of each number
    my @solution = ( map { ($_) x $freq{$_} } @sorted_ints );

    # Display the answer
    say '(', join( ',', @solution ), ')';
}

main(@ARGV);
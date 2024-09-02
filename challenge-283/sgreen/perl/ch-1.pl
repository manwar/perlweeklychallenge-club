#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@ints) {
    # Calculate the frequency of each integer
    my %freq = ();
    foreach my $int (@ints) {
        $freq{$int}++;
    }

    # Get the integers that appear only once
    my @only_once = grep { $freq{$_} == 1 } keys %freq;

    if ( $#only_once == 0 ) {
        say $only_once[0];
    }
    elsif ( $#only_once == -1 ) {
        say 'No values only appear once';
    }
    else {
        say 'More than one value appears once';
    }
}

main(@ARGV);
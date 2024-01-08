#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'zip';

sub main (@inputs) {
    # We need an even number of inputs
    if ( scalar(@inputs) % 2 == 1 ) {
        die "We require an even number of inputs\n";
    }

    # Split the input into words and places
    my $half   = scalar(@inputs) / 2;
    my @words  = @inputs[ 0 .. $half - 1 ];
    my @places = @inputs[ $half .. $#inputs ];

    # Create a dict where the key is the place, and the value is the word
    my %rankings = ( map { @$_ } zip( \@places, \@words ) );

    # Order the words by their ranking
    my @solution = ( map { $rankings{$_} } sort { $a <=> $b } keys %rankings );
    say join ', ', @solution;
}

main(@ARGV);
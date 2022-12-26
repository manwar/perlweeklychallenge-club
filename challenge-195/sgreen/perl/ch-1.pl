#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub is_simple_number ($n) {
    # Determine if the number is simple
    my %seen = ();
    foreach my $i ( split //, $n ) {
        return if $seen{$i}++;
    }
    # It is simple
    return 1;
}

sub main ($n) {
    # Iterate through the list counting the number of simple numbers
    my $simple_count = 0;
    foreach my $i ( 1 .. $n ) {
        $simple_count++ if is_simple_number($i);
    }

    # Print the result
    say $simple_count;
}

main( $ARGV[0] );
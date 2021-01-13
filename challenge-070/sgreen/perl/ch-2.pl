#!/usr/bin/perl

use strict;
use warnings;
use 5.10.1;

sub main (@) {
    my ($bits) = @_;

    # Sanity check
    die "Bits must be a postive integer between 2 and 5"
      unless $bits =~ /^[2-5]$/;

    # Seed the array
    my @values = (0);

    # Double the array for each required bit
    for my $bit ( 1 .. $bits ) {
        my $half = 2**( $bit - 1 );
        push @values, reverse map { $half + $_ } @values;
    }

    say join ' ', @values;
}

main(@ARGV);

#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say);
use List::Util qw(max);

sub main {
    my @array  = @_;
    my @leader = ();

    # Sanity checks
    die "You must specify one or more integers\n" unless scalar @array;
    foreach my $value (@array) {
        die "The value '$value' is not an integer\n"
          unless $value =~ /^-?[0-9]+$/;
    }

    for my $index ( 0 .. $#array - 1 ) {
        # Get the current value, and the maximum of the remaining values
        my $value = $array[$index];
        my $max   = max @array[ $index + 1 .. $#array ];
        push @leader, $value if $value > $max;
    }

    # The last value is always a maximum
    push @leader, $array[-1];
    say '(', join( ', ', @leader ), ')';
}

main(@ARGV);

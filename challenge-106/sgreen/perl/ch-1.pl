#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my @N = @_;

    # Sanity checks
    die "You must enter at least one number\n" if scalar(@N) == 0;
    foreach my $n (@N) {
        die "The value '$n' does not appear to be an integer\n" if $n !~ /^-?\d+$/;
    }

    # Sort the array
    @N = sort { $a <=> $b } @N;

    # Find the maximum difference
    my $max = 0;
    foreach my $i ( 1 .. $#N ) {
        my $diff = $N[$i] - $N[ $i - 1 ];
        $max = $diff if $max < $diff;
    }

    say $max;

}

main(@ARGV);

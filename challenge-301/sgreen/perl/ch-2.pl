#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental qw(bitwise signatures);

sub main (@ints) {
    my $solution = 0;

    # Work through each combination
    foreach my $i ( 0 .. $#ints - 1 ) {
        foreach my $j ( $i + 1 .. $#ints ) {
            # Calculate the xor, convert to binary, count the ones
            my $x = $ints[$i] ^ $ints[$j];
            my $b = sprintf( '%b', $x );
            $solution += ( $b =~ tr/1/1/ );
        }
    }

    say $solution;
}

main(@ARGV);
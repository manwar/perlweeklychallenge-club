#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@arrays) {
    my @arr1 = split /\D+/, $arrays[0];
    my @arr2 = split /\D+/, $arrays[1];

    my $max = 0;
    foreach my $a1 (@arr1) {
        foreach my $a2 (@arr2) {
            my $dist = abs( $a1 - $a2 );
            $max = $dist if $dist > $max;
        }
    }
    say $max;
}

main(@ARGV);

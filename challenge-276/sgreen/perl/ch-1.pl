#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@hours) {
    my $count = 0;

    foreach my $i ( 0 .. $#hours - 1 ) {
        foreach my $j ( $i + 1 .. $#hours ) {
            if ( ( $hours[$i] + $hours[$j] ) % 24 == 0 ) {
                $count++;
            }
        }
    }

    say $count;
}

main(@ARGV);
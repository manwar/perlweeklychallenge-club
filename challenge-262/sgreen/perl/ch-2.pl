#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@ints) {
    # The last value is '$k'
    my $k = pop(@ints);

    my $count = 0;
    foreach my $i ( 0 .. $#ints - 1 ) {
        foreach my $j ( $i + 1 .. $#ints ) {
            if ( $ints[$i] == $ints[$j] and $i * $j % $k == 0 ) {
                ++$count;
            }
        }
    }

    say $count;
}

main(@ARGV);
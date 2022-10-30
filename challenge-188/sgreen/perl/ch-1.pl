#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@list) {
    # Take the last value as 'k'
    my $k       = pop(@list);
    my $matches = 0;

    foreach my $i ( 0 .. $#list - 1 ) {
        foreach my $j ( $i + 1 .. $#list ) {
            if ( ( $list[$i] + $list[$j] ) % $k == 0 ) {
                $matches++;
            }
        }
    }

    say $matches;
}

main(@ARGV);
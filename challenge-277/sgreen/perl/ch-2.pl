#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util qw(min uniq);

sub main (@ints) {
    # Remove duplicates
    @ints = uniq(@ints);
    my $count = 0;

    foreach my $i ( 0 .. $#ints - 1 ) {
        foreach my $j ( $i + 1 .. $#ints ) {
            if ( abs( $ints[$i] - $ints[$j] ) < min( $ints[$i], $ints[$j] ) ) {
                $count++;
            }
        }
    }

    say $count;
}

main(@ARGV);
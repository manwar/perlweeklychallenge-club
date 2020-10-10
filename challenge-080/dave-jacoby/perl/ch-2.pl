#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

say candy_count( 1, 2, 2 );
say candy_count( 1, 4, 3, 2 );

# a) You must given at least one candy to each candidate.
# b) Candidate with higher ranking get more candies than
#   their immediate neighbors on either side.
sub candy_count ( @n ) {
    say join '', map { '-' } @n;
    say join ' ', @n;
    my $total = 0;

    for my $i ( 0 .. $#n ) {
        my $v = $n[$i];
        my $prev = $n[ $i - 1 ] || 0;
        my $next = $n[ $i + 1 ] || 0;
        $total++;       # rule A
        $total++ if $v > $prev && $prev > 0; # rule B.1
        $total++ if $v > $next && $next > 0; # rule B.2
    }
    say '';
    return $total;
}
